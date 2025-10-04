function create():Void{    
    var beautifulSky:FlxSprite = new FlxSprite();
    beautifulSky.makeGraphic(FlxG.width, FlxG.height, 0xFF0D3C3C);
    beautifulSky.camera = camRoom;
    beautifulSky.scrollFactor.set(0, 0);
    add(beautifulSky);
    
    var stars = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/stars.png');
    stars.scrollFactor.set(0, 0);
	stars.setGraphicSize(FlxG.width + 10, stars.height);
	stars.screenCenter();
    stars.y = FlxG.height - stars.height;
    stars.camera = camRoom;
    add(stars);
    
    var hills = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/hills.png');
    hills.scrollFactor.set(1, .5);
	hills.setGraphicSize(FlxG.width + 10, hills.height);
	hills.screenCenter();
    hills.y = FlxG.height - hills.height;
    hills.y += 200;
    hills.camera = camRoom;
    add(hills);
    
    var foreground = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/foreground.png');
	foreground.setGraphicSize(FlxG.width + 10, foreground.height);
	foreground.screenCenter();
    foreground.y = FlxG.height - foreground.height;
    foreground.camera = camRoom;
    add(foreground);
    
    doTransition('fade', 'in', 4, function():Void{
        new FlxTimer().start(2.8, function(f):Void{
            doTransition('fade', 'out', 3, function():Void{
                dialogueBox.loadDialogueFiles(['intro/dia_intro_housefrontscene']);
                dialogueBox.openBox();
                
                PlayState.dialogueOnComplete = function():Void{
                    changeRoom('intro_testroom', 'none', 0);
                };
            });
        });
    });
    
    FlxTween.tween(camRoom.scroll, {y: -440}, 6, {ease: FlxEase.quartInOut});
}