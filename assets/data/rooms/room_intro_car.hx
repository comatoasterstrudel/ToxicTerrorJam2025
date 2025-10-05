var leaving:Bool = false;
var carWindow:FlxSprite;

function create(lastRoom:String):Void
{    
	FlxG.sound.playMusic('assets/sounds/rooms/cardriving.ogg', 0);
	FlxG.sound.music.fadeIn(3, 0, .7);
    
    var beautifulSky:FlxSprite = new FlxSprite();
    beautifulSky.makeGraphic(FlxG.width, FlxG.height, 0xFFCEFFFF);
    beautifulSky.camera = camRoom;
    add(beautifulSky);
    
    var clouds = new FlxBackdrop('assets/images/rooms/intro_car/clouds.png');
    clouds.camera = camRoom;
    clouds.velocity.x = -100;
    add(clouds);
    
    var hills = new FlxBackdrop('assets/images/rooms/intro_car/hills.png');
    hills.camera = camRoom;
    hills.velocity.x = -300;
    add(hills);
    
    var powerLines = new FlxBackdrop('assets/images/rooms/intro_car/electricalLines.png');
    powerLines.camera = camRoom;
    powerLines.velocity.x = -500;
    add(powerLines);
    
	carWindow = new FlxSprite().loadGraphic('assets/images/rooms/intro_car/carWindow.png');
	carWindow.setGraphicSize(FlxG.width + 10, FlxG.height + 40);
	carWindow.screenCenter();
    carWindow.camera = camRoom;
    add(carWindow);
    
    doTransition('fade', 'in', 3, function():Void{
		dialogueBox.loadDialogueFiles(['intro/dia_intro_carscene']);
		dialogueBox.openBox();
        
        PlayState.dialogueOnComplete = function():Void{
			leaving = true;
			FlxG.sound.music.fadeOut(3, 0);
            changeRoom('intro_housefront', 'fade', 3);
        };
	});   
	doBump();
}

function doBump():Void
{
	if (!leaving)
	{
		new FlxTimer().start(FlxG.random.float(5, 11), function(f):Void
		{
			FlxG.sound.play('assets/sounds/rooms/carbump.ogg', FlxG.random.float(.1, .5)).pitch = FlxG.random.float(.8, 1.2);

			var ogY = carWindow.y;

			carWindow.y += (FlxG.random.bool(50)) ? FlxG.random.float(5, 20) : FlxG.random.float(-20, -5);

			FlxTween.tween(carWindow, {y: ogY}, .5, {
				ease: FlxEase.elasticOut,
				onComplete: function(f):Void
				{
					doBump();
				}
			});
		});
	}
}