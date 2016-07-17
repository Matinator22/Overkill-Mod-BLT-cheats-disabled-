--=====================--
--     OVERKILL MOD    --
--     APPLE TOGGLE    --
--=====================--
-- r2.2
if not _cheatToggle then
	_cheatToggle = true

	managers.mission._fading_debug_output:script().log(' ACTIVATED ', Color("97d04d") )
	managers.mission._fading_debug_output:script().log(' OVERKILL MOD : ', tweak_data.system_chat_color )
	elseif _cheatToggle then
	_cheatToggle = false
	
	if toggleMark then
	toggleMark = false
	markClear()
	end
	
	if Toggle.godMode then
	Toggle.godMode = false
	managers.player:player_unit():character_damage():set_god_mode(false)
	managers.mission._fading_debug_output:script().log("GODMODE : DISABLED", Color("FFE29D"))
	end
	
	if Toggle.clkCounter then
	Toggle.clkCounter = false
	backuper:restore('PlayerMovement.on_SPOOCed')
	end
	
	if Toggle.fbMode then
	Toggle.fbMode = false
	backuper:restore('CoreEnvironmentControllerManager.set_flashbang')
	end
	
	if Toggle.shockMode then
	Toggle.shockMode = false
	backuper:restore('PlayerTased.enter')
	end
	
	if Toggle.fallMode then
	Toggle.fallMode = false
	backuper:restore('PlayerDamage.damage_fall')
	end
	
	if Toggle.runMode then
	Toggle.runMode = false
	backuper:restore('PlayerMovement._change_stamina')
	backuper:restore('PlayerMovement.is_stamina_drained')
	end
	
	if Toggle.pugilistMode then
	Toggle.pugilistMode = false
	backuper:restore('CopDamage.damage_melee')
	end
	
	if Toggle.nadeMode then
	Toggle.nadeMode = false
	backuper:restore('CopDamage.damage_explosion') 
	end
	
	if Toggle.infMode then
	Toggle.infMode = false
	backuper:restore("NewRaycastWeaponBase.fire")
	backuper:restore("SawWeaponBase.fire")
	end
	
	if Toggle.shellMode then
	Toggle.shellMode = false
	backuper:restore("InstantBulletBase.on_collision")
	backuper:restore("InstantExplosiveBulletBase.on_collision")
	backuper:restore("InstantExplosiveBulletBase.on_collision_server")
	end
	
	if Toggle.weapon_reload then
	Toggle.weapon_reload = false
	backuper:restore('NewRaycastWeaponBase.reload_speed_multiplier')
	end
	
	if Toggle.weapon_swap then
	Toggle.weapon_swap = false
	backuper:restore('PlayerStandard._get_swap_speed_multiplier')
	end
	
	if Toggle.weapon_firerate then
	Toggle.weapon_firerate = false
	backuper:restore('NewRaycastWeaponBase.fire_rate_multiplier')
	end
	
	if Toggle.weapon_dmg then
	Toggle.weapon_dmg = false
	backuper:restore('CopDamage:damage_bullet')
	end
	
	if Toggle.drillautofix then
	Toggle.drillautofix = false
	backuper:restore('Drill.set_jammed')
	end
	
	if Toggle.intInst then
	Toggle.intInst = false
	backuper:restore('BaseInteractionExt._get_timer')
	backuper:restore('PlayerManager.selected_equipment_deploy_timer')
	end
	
	if Toggle.intAll then
	Toggle.intAll = false
	backuper:restore('BaseInteractionExt._has_required_upgrade')
	backuper:restore('BaseInteractionExt._has_required_deployable')
	backuper:restore('BaseInteractionExt.can_interact')
	backuper:restore('PlayerManager.remove_equipment')
	end
	
	if Toggle.intDist then
	Toggle.intDist = false
	backuper:restore('BaseInteractionExt.interact_distance')
	end
	
	if Toggle.intWall then
	Toggle.intWall = false
	backuper:restore('ObjectInteractionManager._update_targeted')
	backuper:restore('ObjectInteractionManager.interact')
	end
	
	if Toggle.drillInst then
	Toggle.drillInst = false
	backuper:restore('TimerGui.update')
	end
	
	if Toggle.drillDEF then
	Toggle.drillDEF = false
	backuper:restore('Drill:_register_sabotage_SO')
	end
	
	if Toggle.freeKill then
	Toggle.freeKill = false
	backuper:restore('MoneyManager.get_civilian_deduction')
	backuper:restore('MoneyManager.civilian_killed')
	backuper:restore('UnitNetworkHandler.sync_hostage_killed_warning')
	end
	
	if Toggle.xpMulti then
	Toggle.xpMulti = false
	backuper:restore('ExperienceManager.give_experience')
	end
	
	if Toggle.godSentry then
	Toggle.godsentry = false
	backuper:restore("SentryGunDamage.damage_bullet")
	end
	
	if Toggle.infSentry then
	Toggle.infsentry = false
	backuper:restore("SentryGunWeapon.fire")
	end
	
	if Toggle.infPager then
	Toggle.infpager = false
	backuper:restore("GroupAIStateBase.on_successful_alarm_pager_bluff")
	end
	
	if Toggle.infECM then
	Toggle.infECM = false
	backuper:restore("ECMJammerBase.update")
	end
	
	if Toggle.infAmmobag then
	Toggle.infammobag = false
	backuper:restore("AmmoBagBase._take_ammo")
	end
	
	if Toggle.infDocbag then
	Toggle.infdocbag = false
	backuper:restore("DoctorBagBase._take")
	end
	
	if Toggle.ffon then
	Toggle.ffon = false
	backuper:restore('PlayerDamage.is_friendly_fire')
	end
	
	if Toggle.clkrArrest then
	Toggle.clkrArrest = false
	backuper:restore('PlayerMovement.on_SPOOCed')
	backuper:restore('TeamAIMovement:on_SPOOCed')
	end
	
	if Toggle.disableCam then
	Toggle.disableCam = false
		for _,unit in pairs(GroupAIStateBase._security_cameras) do
			unit:base():set_update_enabled(true)
		end
	end
	
	if Toggle.disablePager then
	Toggle.disablePager = false
	backuper:restore('CopLogicInactive._set_interaction')
	backuper:restore('CopLogicIntimidated._chk_begin_alarm_pager')
	end
	
	if Toggle.disablePanic then
	Toggle.disablePanic = false
	backuper:restore('CopMovement.action_request')
	end
	
	if Toggle.disableCall then
	Toggle.disableCall = false
	backuper:restore('GroupAIStateBase.on_police_called')
	backuper:restore('CivilianLogicFlee.clbk_chk_call_the_police')
	end
	
	if Toggle.disableCop then
	Toggle.disableCop = false
	backuper:restore('CopMovement.set_allow_fire')
	backuper:restore('CopMovement.set_allow_fire_on_client')
	end

	managers.mission._fading_debug_output:script().log(' DEACTIVATED ', Color.Orange )
	managers.mission._fading_debug_output:script().log(' OVERKILL MOD : ',  tweak_data.system_chat_color )
end