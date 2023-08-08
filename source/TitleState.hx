package;

import flixel.text.FlxText;
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
	var splashText:FlxText;
	var bg:FlxSprite;
	var titleBF:FlxSprite; // Character;
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

		// Highscore.load();

		if (FlxG.save.data.weekCompleted != null)
		{
			// StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(EXT.music('Inst'), 1);

			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}

		Conductor.changeBPM(85);

		bg = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFF54A4FF);
		bg.origin.set(0, 0);
		bg.screenCenter();
		add(bg);

		logoBl = new FlxSprite(20, 20).loadGraphic('assets/images/placeholder logo.png');
		add(logoBl);

		splashText = new FlxText(80, 590, 600, 'Press Enter to Start', 36);
		splashText.setFormat('assets/fonts/pop-happiness.otf', 52, FlxColor.WHITE, CENTER, SHADOW, FlxColor.BLACK);
		splashText.borderSize = 2;
		splashText.shadowOffset.set(0, 3);
		add(splashText);

		titleBF = new FlxSprite(840, 80).makeGraphic(300, 440, 0xFFFF3D3D);
		add(titleBF);

		FlxG.camera.flash(FlxColor.WHITE, 1.7);
	}

	override function update(elapsed:Float)
	{
		titleBF.angle += 80 * elapsed;

		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

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
				FlxG.sound.play(EXT.sound('start'));
				//splashText.y = 570;
				transitioning = true;

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					MusicBeatState.resetState();
				});
			}
		}
		super.update(elapsed);
	}

	function tweenBack(tween:FlxTween):Void
	{
		FlxTween.tween(splashText.scale, {x: 0.975, y: 0.975}, (60 / Conductor.bpm) * 0.25, {ease: FlxEase.cubeOut, type: FlxTweenType.PERSIST});
		FlxTween.tween(logoBl.scale, {x: 0.975, y: 0.975}, (60 / Conductor.bpm) * 0.25, {ease: FlxEase.cubeOut, type: FlxTweenType.PERSIST});
	}

	override function beatHit()
	{
		super.beatHit();
		if (splashText != null)
			FlxTween.tween(splashText.scale, {x: 1, y: 1}, (60 / Conductor.bpm) * 0.25, {type: FlxTweenType.PERSIST, ease: FlxEase.cubeOut});
		if (logoBl != null)
			FlxTween.tween(logoBl.scale, {x: 1, y: 1}, (60 / Conductor.bpm) * 0.25,
				{type: FlxTweenType.PERSIST, ease: FlxEase.cubeOut, onComplete: tweenBack});

		//if (titleBF != null)
			// titleBF.dance();
	}
}
