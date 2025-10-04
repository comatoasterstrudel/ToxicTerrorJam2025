function create(lastRoom:String):Void
{
	FlxG.sound.playMusic('assets/sounds/rooms/crickets.ogg', 0);
	FlxG.sound.music.fadeIn(3, 0, 1);
	
    var beautifulSky:FlxSprite = new FlxSprite();
    beautifulSky.makeGraphic(FlxG.width, FlxG.height, 0xFF0D3C3C);
    beautifulSky.camera = camRoom;
    beautifulSky.scrollFactor.set(0, 0);
    add(beautifulSky);
    
    var stars = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/stars.png');
	stars.scrollFactor.set(0, 0);
	stars.screenCenter();
	stars.x = 0;
    stars.camera = camRoom;
    add(stars);
    
    var hills = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/hills.png');
	hills.scrollFactor.set(.5, 1);
	hills.screenCenter();
	hills.x = 0;
    hills.camera = camRoom;
    add(hills);
    
	var ground = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/ground.png');
	ground.scrollFactor.set(.8, 1);
	ground.screenCenter();
	ground.x = 0;
	ground.camera = camRoom;
	add(ground);

	var house = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/house.png');
	house.scrollFactor.set(.87, 1);
	house.screenCenter();
	house.x = 0;
	house.camera = camRoom;
	add(house);

	var garage = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/garage.png');
	garage.scrollFactor.set(.9, 1);
	garage.screenCenter();
	garage.x = 0;
	garage.camera = camRoom;
	add(garage);

	var meicar = new FlxSprite().loadGraphic('assets/images/rooms/intro_housefront/meicar.png');
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
    
	FlxTween.tween(camRoom.scroll, {x: 450}, 6, {ease: FlxEase.quartInOut});
}