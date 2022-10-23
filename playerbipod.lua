local _update_check_actions = PlayerBipod._update_check_actions
function PlayerBipod:_update_check_actions(t, dt)
	local input = self:_get_input(t, dt)

	self:_determine_move_direction()
	self:_update_interaction_timers(t)
	self:_update_throw_projectile_timers(t, input)
	self:_update_reload_timers(t, dt, input)
	self:_update_melee_timers(t, input)
	self:_update_equip_weapon_timers(t, input)
	self:_update_running_timers(t)
	self:_update_zipline_timers(t, dt)

	if input.btn_stats_screen_press then
		self._unit:base():set_stats_screen_visible(true)
	elseif input.btn_stats_screen_release then
		self._unit:base():set_stats_screen_visible(false)
	end

	self:_update_foley(t, input)

	local new_action = false
	new_action = self:_check_action_reload(t, input)
	new_action = new_action or self:_check_action_weapon_gadget(t, input)	
	new_action = new_action or self:_check_action_jump(t, input)
	new_action = new_action or self:_check_action_run(t, input)
	new_action = new_action or self:_check_change_weapon(t, input)
	new_action = new_action or self:_check_action_unmount_bipod(t, input)

	if not new_action then
		new_action = self:_check_action_primary_attack(t, input)

		if not new_action then
			self:_check_stop_shooting()
		end

		self._shooting = new_action
	end

	-- new_action = new_action or self:_check_action_jump(t, input)
	-- new_action = new_action or self:_check_action_run(t, input)
	-- new_action = new_action or self:_check_change_weapon(t, input)
	-- new_action = new_action or self:_check_action_unmount_bipod(t, input)
	new_action = new_action or self:_check_action_intimidate(t, input)
	new_action = new_action or self:_check_action_throw_projectile(t, input)

	self:_check_action_steelsight(t, input)
	self:_check_use_item(t, input)
	self:_check_action_night_vision(t, input)
	self:_find_pickups(t)
	-- _update_check_actions(self, t, dt)
end