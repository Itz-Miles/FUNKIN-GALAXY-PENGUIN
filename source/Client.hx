package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.graphics.FlxGraphic;
import Controls;

class ClientPrefs
{
	public static var downScroll:Bool = false;
	public static var framerate:Int = 60;
	public static var showFPS:Bool = true;
	public static var noteOffset:Int = 0;
	public static var timeBarType:String = 'Time Left';
	public static var hudAlpha:Float = 1;
	public static var difficulty:String = 'Hard';

	public static var hitsoundVolume:Float = 0;
	public static var relativeHitCalc:Bool = true;

	public static var ratingOffset:Int = 0;
	public static var hitWindow:Float = 100; // ms

	// Every key has two binds, add your key bind down here and then add your control on options/ControlsSubState.hx and Controls.hx
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		// Key Bind, Name for ControlsSubState
		'note_up' => [J, UP],
		'note_left' => [D, LEFT],
		'note_down' => [F, DOWN],
		'note_right' => [K, RIGHT],
		'ui_up' => [W, UP],
		'ui_left' => [A, LEFT],
		'ui_down' => [S, DOWN],
		'ui_right' => [D, RIGHT],
		'accept' => [SPACE, ENTER],
		'back' => [BACKSPACE, ESCAPE],
		'pause' => [ENTER, ESCAPE],
		'reset' => [R],
		'volume_mute' => [ZERO],
		'volume_up' => [NUMPADPLUS, PLUS],
		'volume_down' => [NUMPADMINUS, MINUS],
	];
	public static var gamepadBinds:Map<String, Array<FlxGamepadInputID>> = [
		'note_up' => [DPAD_UP, LEFT_STICK_DIGITAL_UP, RIGHT_STICK_DIGITAL_UP, Y],
		'note_left' => [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT, RIGHT_STICK_DIGITAL_LEFT, X],
		'note_down' => [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN, RIGHT_STICK_DIGITAL_DOWN, A],
		'note_right' => [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT, RIGHT_STICK_DIGITAL_RIGHT, B],
		'ui_up' => [DPAD_UP, LEFT_STICK_DIGITAL_UP],
		'ui_left' => [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'ui_down' => [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
		'ui_right' => [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
		'accept' => [A, START],
		'back' => [B],
		'pause' => [START],
		'reset' => [8]
	];
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	public static function loadDefaultKeys()
	{
		defaultKeys = keyBinds.copy();
		// trace(defaultKeys);
	}

	public static function saveSettings()
	{
		FlxG.save.data.downScroll = downScroll;
		FlxG.save.data.framerate = framerate;
		FlxG.save.data.showFPS = showFPS;
		FlxG.save.data.noteOffset = noteOffset;
		FlxG.save.data.timeBarType = timeBarType;
		FlxG.save.data.hudAlpha = hudAlpha;

		FlxG.save.data.difficulty = difficulty;
		FlxG.save.data.hitsoundVolume = hitsoundVolume;
		FlxG.save.data.relativeHitCalc = relativeHitCalc;
		FlxG.save.data.ratingOffset = ratingOffset;
		FlxG.save.data.hitWindow = hitWindow;

		FlxG.save.flush();

		var save:FlxSave = new FlxSave();
		save.bind('controls', CoolUtil.getSavePath());
		save.data.customControls = keyBinds;
		save.flush();
		FlxG.log.add("Settings saved!");
	}

	public static function loadPrefs()
	{
		if (FlxG.save.data.downScroll != null)
		{
			downScroll = FlxG.save.data.downScroll;
		}

		if (FlxG.save.data.framerate != null)
		{
			framerate = FlxG.save.data.framerate;
			if (framerate > FlxG.drawFramerate)
			{
				FlxG.updateFramerate = framerate;
				FlxG.drawFramerate = framerate;
			}
			else
			{
				FlxG.drawFramerate = framerate;
				FlxG.updateFramerate = framerate;
			}
		}

		if (FlxG.save.data.showFPS != null)
		{
			showFPS = FlxG.save.data.showFPS;
			if (Main.fpsVar != null)
			{
				Main.fpsVar.visible = showFPS;
			}
		}

		if (FlxG.save.data.noteOffset != null)
		{
			noteOffset = FlxG.save.data.noteOffset;
		}

		if (FlxG.save.data.timeBarType != null)
		{
			timeBarType = FlxG.save.data.timeBarType;
		}

		if (FlxG.save.data.hudAlpha != null)
		{
			hudAlpha = FlxG.save.data.hudAlpha;
		}

		if (FlxG.save.data.difficulty != null)
		{
			difficulty = FlxG.save.data.difficulty;
		}

		if (FlxG.save.data.hitsoundVolume != null)
		{
			hitsoundVolume = FlxG.save.data.hitsoundVolume;
		}

		if (FlxG.save.data.relativeHitCalc != null)
		{
			relativeHitCalc = FlxG.save.data.relativeHitCalc;
		}

		if (FlxG.save.data.ratingOffset != null)
		{
			ratingOffset = FlxG.save.data.ratingOffset;
		}

		if (FlxG.save.data.hitWindow != null)
			{
				hitWindow = FlxG.save.data.hitWindow;
			}

		var save:FlxSave = new FlxSave();
		save.bind('controls', CoolUtil.getSavePath());
		if (save != null && save.data.customControls != null)
		{
			var loadedControls:Map<String, Array<FlxKey>> = save.data.customControls;
			for (control => keys in loadedControls)
			{
				keyBinds.set(control, keys);
			}
			reloadControls();
		}
	}

	public static function reloadControls()
	{
		TitleState.muteKeys = keyBinds.get('volume_mute').copy();
		TitleState.volumeDownKeys = keyBinds.get('volume_down').copy();
		TitleState.volumeUpKeys = keyBinds.get('volume_up').copy();
		FlxG.sound.muteKeys = TitleState.muteKeys;
		FlxG.sound.volumeDownKeys = TitleState.volumeDownKeys;
		FlxG.sound.volumeUpKeys = TitleState.volumeUpKeys;
	}
}
