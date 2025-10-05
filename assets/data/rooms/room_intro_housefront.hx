function create(lastRoom:String):Void
{
	FlxG.sound.playMusic('assets/sounds/rooms/crickets.ogg', 0);
	FlxG.sound.music.fadeIn(3, 0, 1);
	
    var beautifulSky:FlxSprite = new FlxSprite();
    beautifulSky.makeGraphic(FlxG.width, FlxG.height, 0xFF0D3C3C);
    beautifulSky.camera = camRoom;
    beautifulSky.scrollFactor.set(0, 0);
	// add(beautifulSky);
    
	var sky = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/sky.png');
	sky.scrollFactor.set(0, 0);
	sky.screenCenter();
	sky.x = 0;
	sky.camera = camRoom;
	add(sky);
    
    var hills = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/hills.png');
	hills.scrollFactor.set(.5, 1);
	hills.setGraphicSize(hills.width + 40, hills.height);
	hills.updateHitbox();
	hills.screenCenter();
	hills.x = -20;
    hills.camera = camRoom;
    add(hills);
    
	var ground = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/ground.png');
	ground.scrollFactor.set(.87, 1);
	ground.setGraphicSize(ground.width + 40, ground.height);
	ground.updateHitbox();
	ground.screenCenter();
	ground.x = 0;
	ground.camera = camRoom;
	add(ground);

	var house = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/house.png');
	house.scrollFactor.set(.87, 1);
	house.setGraphicSize(house.width + 40, house.height);
	house.updateHitbox();
	house.screenCenter();
	house.x = 0;
	house.camera = camRoom;
	add(house);

	var meicar = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/meicar.png');
	meicar.scrollFactor.set(1.3, 1);
	meicar.screenCenter();
	meicar.x = 0;
	meicar.camera = camRoom;
	add(meicar);
    
    doTransition('fade', 'in', 4, function():Void{
        new FlxTimer().start(2.8, function(f):Void{
			FlxG.sound.music.fadeOut(3, .3);
            doTransition('fade', 'out', 3, function():Void{
                dialogueBox.loadDialogueFiles(['intro/dia_intro_housefrontscene']);
                dialogueBox.openBox();
                
                PlayState.dialogueOnComplete = function():Void{
					changeRoom('test_placeholder', 'none', 0);
                };
            });
        });
    });
    
	FlxTween.tween(camRoom.scroll, {x: 35}, 6, {ease: FlxEase.quartInOut});
}