local capabilities = require 'st.capabilities'
local defaults = require 'st.zigbee.defaults'
local log = require('log')
local zcl_clusters = require('st.zigbee.zcl.clusters')
local zigbee_driver = require 'st.zigbee'

local top_button_pressed_handler = function(_, device, _)
    log.trace('Handling top button press')
    device:emit_event(capabilities.button.button.up({state_change = true}))
end

local bottom_button_pressed_handler = function(_, device, _)
    log.trace('Handling bottom button press')
    device:emit_event(capabilities.button.button.down({state_change = true}))
end

local button_held_handler = function(_, device, zb_rx, _, _)
    log.trace('Handling button hold')
    local move_mode = zb_rx.body.zcl_body.move_mode.value
    local args = {state_change = true}

    if move_mode == zcl_clusters.Level.types.MoveStepMode.UP then
        device:emit_event(capabilities.button.button.up_hold(args))
    elseif move_mode == zcl_clusters.Level.types.MoveStepMode.DOWN then
        device:emit_event(capabilities.button.button.down_hold(args))
    end
end

local battery_level_handler = function(_, device, value)
    log.trace('Handling battery level update')
    device:emit_event(capabilities.battery.battery(value.value))
end

local device_added = function(_, device)
    device:emit_event(capabilities.button.supportedButtonValues({
        'up', 'up_hold', 'down', 'down_hold'
    }))
end

local do_configure = function(_, device)
    device:configure()
    device:send(zcl_clusters.PowerConfiguration.attributes
                    .BatteryPercentageRemaining:read(device))
end

local ikea_switch_driver = {
    supported_capabilities = {capabilities.button, capabilities.battery},
    zigbee_handlers = {
        attr = {
            [zcl_clusters.PowerConfiguration.ID] = {
                [zcl_clusters.PowerConfiguration.attributes
                    .BatteryPercentageRemaining.ID] = battery_level_handler
            }
        },
        cluster = {
            [zcl_clusters.OnOff.ID] = {
                [zcl_clusters.OnOff.server.commands.On.ID] = top_button_pressed_handler,
                [zcl_clusters.OnOff.server.commands.Off.ID] = bottom_button_pressed_handler
            },
            [zcl_clusters.Level.ID] = {
                [zcl_clusters.Level.server.commands.MoveWithOnOff.ID] = button_held_handler,
                [zcl_clusters.Level.server.commands.Move.ID] = button_held_handler
            }
        }
    },
    lifecycle_handlers = {added = device_added, doConfigure = do_configure}
}

defaults.register_for_default_handlers(ikea_switch_driver,
                                       ikea_switch_driver.supported_capabilities)
local driver = zigbee_driver('ikea-remote', ikea_switch_driver)
driver:run()
