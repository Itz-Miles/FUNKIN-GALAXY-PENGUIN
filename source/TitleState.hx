package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

using StringTools;

class TitleState extends MusicBeatState
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

	var logoBl:FlxSprite;
	var splashText:FlxSprite;
	var bg:FlxSprite;
	// var titleGF:Character;
	var transitioning:Bool;
	var gamepad:FlxGamepad;
	var pressedEnter:Bool;

	override public function create():Void
	{
		super.create();

		FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = muteKeys;
		FlxG.sound.volumeDownKeys = volumeDownKeys;
		FlxG.sound.volumeUpKeys = volumeUpKeys;
		FlxG.keys.preventDefaultKeys = [TAB];
		gamepad = FlxG.gamepads.lastActive;

		PlayerSettings.init();

		FlxG.save.bind('funkin', CoolUtil.getSavePath());
		Client.loadPrefs();

		//Highscore.load();

		if (FlxG.save.data.weekCompleted != null)
		{
			//StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic('assets/music/Inst.mp3', 1);

			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}

		Conductor.changeBPM(102);

		bg = new FlxSprite(0, 0).loadGraphic('');
		bg.makeGraphic(1280, 720, 0xFF9AC9FF);
		bg.origin.set(0, 0);
		bg.screenCenter();
		add(bg);

		logoBl = new FlxSprite(-15, -10).makeGraphic(427, 240, 0xffff0000);
		logoBl.updateHitbox();
		add(logoBl);

		splashText = new FlxSprite(0, 560).makeGraphic(1280, 97, 0xffff0000);
		splashText.updateHitbox();
		splashText.screenCenter(X);
		add(splashText);
		FlxTween.tween(splashText.scale, {x: 0.76, y: 0.76}, 0.1, {ease: FlxEase.cubeOut, type: FlxTweenType.PERSIST});

		// titleGF = new Character(758, 219, "titleGF", false, "shared");
		// add(titleGF);

		FlxG.camera.flash(FlxColor.WHITE, 1.7);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		if (FlxG.keys.justPressed.ENTER || controls.ACCEPT)
			pressedEnter = true;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		if (!transitioning)
		{
			if (pressedEnter)
			{
				//FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
				splashText.y = 570;
				transitioning = true;

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					//MusicBeatState.switchState(new MainMenuState());
				});
			}
		}
		super.update(elapsed);
	}

	function tweenBack(tween:FlxTween):Void
	{
		FlxTween.tween(splashText.scale, {x: 0.76, y: 0.76}, 0.165, {ease: FlxEase.cubeOut, type: FlxTweenType.PERSIST});
		FlxTween.tween(logoBl.scale, {x: 0.975, y: 0.975}, 0.165, {ease: FlxEase.cubeOut, type: FlxTweenType.PERSIST});
	}

	override function beatHit()
	{
		super.beatHit();
		if (splashText != null)
			FlxTween.tween(splashText.scale, {x: 0.79, y: 0.79}, 0.165, {type: FlxTweenType.PERSIST, ease: FlxEase.cubeOut, onComplete: tweenBack});
		if (splashText != null)
			splashText.y = 560; // might tween back later
		if (logoBl != null)
			FlxTween.tween(logoBl.scale, {x: 1, y: 1}, 0.165, {type: FlxTweenType.PERSIST, ease: FlxEase.cubeOut, onComplete: tweenBack});

		/*
			if (titleGF != null)
			{
			titleGF.dance();
			}
		 */
	}
}
