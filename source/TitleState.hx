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
	var titleBF:FlxSprite;
	var transitioning:Bool;
	var gamepad:FlxGamepad;
	var pressedEnter:Bool;

	override public function create():Void
	{
		super.create();

		gamepad = FlxG.gamepads.lastActive;

		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(EXT.music('title'), 0);

			FlxG.sound.music.fadeIn(4, 0, 1);
		}

		Conductor.changeBPM(72);

		bg = new FlxSprite(0, 0).loadGraphic(EXT.png('space'));
		bg.origin.set(0, 0);
		bg.screenCenter();
		add(bg);

		logoBl = new FlxSprite(520, -520).loadGraphic(EXT.png('placeholder logo'));
		add(logoBl);
		FlxTween.tween(logoBl, {x: 20, y: 20}, (60 / Conductor.bpm), {ease: FlxEase.cubeInOut, type: FlxTweenType.PERSIST});

		splashText = new FlxText(580, 1090, 600, 'Press Enter to Start', 36);
		splashText.setFormat('assets/fonts/pop-happiness.otf', 52, FlxColor.WHITE, CENTER, SHADOW, FlxColor.BLACK);
		splashText.borderSize = 2;
		splashText.shadowOffset.set(0, 3);
		add(splashText);
		FlxTween.tween(splashText, {x: 80, y: 590}, (60 / Conductor.bpm), {ease: FlxEase.cubeInOut, type: FlxTweenType.PERSIST});

		titleBF = new FlxSprite(1580, 80).loadGraphic(EXT.png('bf woah still'));
		titleBF.origin.x += 20;
		titleBF.scale.set(1.5, 1.5);
		add(titleBF);
		titleBF.angle = Std.random(361);
		FlxTween.tween(titleBF, {
			x: 780,
			y: 180,
			"scale.x": 1.0,
			"scale.y": 1.0
		}, (60 / Conductor.bpm) * 2,
			{ease: FlxEase.cubeInOut, type: FlxTweenType.PERSIST});

		FlxG.camera.flash(FlxColor.WHITE, 1.7);
	}

	override function update(elapsed:Float)
	{
		titleBF.angle += 68 * elapsed;

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
				transitioning = true;
				FlxG.sound.play(EXT.sound('start'));

				FlxTween.tween(logoBl, {x: -500, y: -552}, (60 / Conductor.bpm), {ease: FlxEase.quadIn, type: FlxTweenType.PERSIST});
				FlxTween.tween(splashText, {x: -500, y: FlxG.height + 552}, (60 / Conductor.bpm), {ease: FlxEase.quadIn, type: FlxTweenType.PERSIST});

				new FlxTimer().start((60 / Conductor.bpm) * 0.5, function(tmr:FlxTimer)
				{
					FlxG.camera.fade(FlxColor.WHITE, (60 / Conductor.bpm) * 2);
					FlxTween.tween(titleBF, {
						x: -500,
						y: 350,
						"scale.x": 0.5,
						"scale.y": 0.5
					}, (60 / Conductor.bpm) * 2, {ease: FlxEase.cubeIn, type: FlxTweenType.PERSIST});
					new FlxTimer().start((60 / Conductor.bpm) * 2, function(tmr:FlxTimer)
					{
						FlxG.resetState();
					});
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
	}

	override public function destroy()
	{
		//super.destroy();
		logoBl = null;
		splashText = null;
		bg = null;
		titleBF = null;
		gamepad = null;
	}
}
