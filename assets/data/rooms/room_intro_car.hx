function create():Void{    
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
    
    var carWindow = new FlxSprite().loadGraphic('assets/images/rooms/intro_car/carWindow.png');
	carWindow.setGraphicSize(FlxG.width + 10, FlxG.height);
	carWindow.screenCenter();
    carWindow.camera = camRoom;
    add(carWindow);
    
    doTransition('fade', 'in', 3, function():Void{
		dialogueBox.loadDialogueFiles(['intro/dia_intro_carscene']);
		dialogueBox.openBox();
        
        PlayState.dialogueOnComplete = function():Void{
            changeRoom('intro_housefront', 'fade', 3);
        };
    });
}