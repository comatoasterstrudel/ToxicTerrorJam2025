package menu;

/**
 * this is the class that holds the main menu.
 */
class MainMenuState extends FlxState
{
	/**
	 * the list of menu options to appear on this menu
	 */
	var menuOptions:Array<MainMenuOption> = [
		{
			name: "New Game",
			selectedFunction: function():Void
			{
				PlayState.storyMode = true;
				SaveData.resetSaveData();
				SaveData.startedGame = true;
				PlayState.loadRoom(Constants.FIRST_ROOM);
				FlxG.switchState(new PlayState());
			}
		},
		{
			name: "Load Game",
			selectedFunction: function():Void
			{
				PlayState.storyMode = true;

				if (SaveData.startedGame)
				{
					PlayState.loadRoom(SaveData.savedCurRoom, SaveData.savedLastRoom);
					FlxG.switchState(new PlayState());
				}
				else
				{
					trace('Cant Continue. You havent even started!!');
				}
			}
		},
		{
			name: "Credits",
			selectedFunction: function():Void
			{
				trace('we made it ahah');
			}
		},
		{
			name: "Reset Save Data",
			selectedFunction: function():Void
			{
				SaveData.resetSaveData();
				FlxG.resetState();
			}
		},
		{
			name: "Quit",
			selectedFunction: function():Void
			{
				Sys.exit(0);
			}
		},
	];

	/**
	 * the group of texts that are displayed on this menu
	 */
	var menuTexts:FlxSpriteGroup;

	/**
	 * the bg sprite
	 */
	var menuBg:FlxSprite;
	
	/**
	 * the logo of the game
	 */
	var gameLogo:FlxSprite;
	
	override public function create()
	{
		super.create();
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();
		
		menuBg = new FlxSprite().loadGraphic('assets/images/menu/bg.png');
		menuBg.setGraphicSize(FlxG.width, FlxG.height);
		menuBg.screenCenter();
		add(menuBg);

		gameLogo = new FlxSprite(10, 10).loadGraphic('assets/images/menu/logo.png');
		add(gameLogo);
		
		#if debug
		menuOptions.push({
			name: "Dbg: Test Dialogue Box",
			selectedFunction: function():Void
			{
				var box = new CtDialogueBox();
				add(box);
				box.loadDialogueFiles(['test/dia_test_real_real']);
				box.openBox();
			}
		});
		menuOptions.push({
			name: "Dbg: Test Frame Room",
			selectedFunction: function():Void
			{
				PlayState.storyMode = false;

				PlayState.loadRoom('test_frames');
				FlxG.switchState(new PlayState());
			}
		});
		menuOptions.push({
			name: "Dbg: front of house scene",
			selectedFunction: function():Void
			{
				PlayState.storyMode = false;
				
				PlayState.loadRoom('intro_housefront');
				FlxG.switchState(new PlayState());
			}
		});
		menuOptions.push({
			name: "Dbg: house entrance scene",
			selectedFunction: function():Void
			{
				PlayState.storyMode = false;
				
				PlayState.loadRoom('intro_houseentrance');
				FlxG.switchState(new PlayState());
			}
		});
		menuOptions.push({
			name: "Dbg: test interactables",
			selectedFunction: function():Void
			{
				PlayState.storyMode = false;
				
				PlayState.loadRoom('test_interactables');
				FlxG.switchState(new PlayState());
			}
		});
		menuOptions.push({
			name: "Dbg: get item list",
			selectedFunction: function():Void
			{
				trace(Items.getItemList());
				for (i in Items.getItemList())
				{
					trace(new ItemData(i).vanityName);
				}
			}
		});
		#end
		
		menuTexts = new FlxSpriteGroup();
		add(menuTexts);

		for (i in 0...menuOptions.length)
		{
			var menuOption = menuOptions[i];

			var menuText = new FlxText(10, gameLogo.y + gameLogo.height + (40 * i), 0, menuOption.name, 16);
			menuText.ID = i;
			menuTexts.add(menuText);
			if (menuOption.name == "Load Game" && !SaveData.startedGame)
				menuText.color = FlxColor.GRAY; // i know this is jank suck my cock ernie keebler
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		for (i in menuTexts)
		{
			if (FlxG.mouse.overlaps(i) && i.color == FlxColor.WHITE)
			{ 
				i.alpha = 1;
				if (FlxG.mouse.justReleased)
				{
					menuOptions[i.ID].selectedFunction();
				}
			}
			else
			{
				i.alpha = .5;
			}
		}
	}
}
