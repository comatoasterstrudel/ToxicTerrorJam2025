package menu;

import flixel.group.FlxSpriteGroup;

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
			name: "Start Game",
			selectedFunction: function():Void
			{
				PlayState.loadRoom('intro_car');
				FlxG.switchState(new PlayState());
			}
		},
		{
			name: "Load Game",
			selectedFunction: function():Void
			{
				FlxG.switchState(new PlayState());
			}
		},
		{
			name: "Credits",
			selectedFunction: function():Void
			{
				trace('we made it ahah');
			}
		},
		#if windows
		{
			name: "Quit",
			selectedFunction: function():Void
			{
				Sys.exit(0);
			}
		},
		#end
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
				PlayState.loadRoom('test_frames');
				FlxG.switchState(new PlayState());
			}
		});
		menuOptions.push({
			name: "Dbg: front of house scene",
			selectedFunction: function():Void
			{
				PlayState.loadRoom('intro_housefront');
				FlxG.switchState(new PlayState());
			}
		});
		menuOptions.push({
			name: "Dbg: test interactables",
			selectedFunction: function():Void
			{
				PlayState.loadRoom('test_interactables');
				FlxG.switchState(new PlayState());
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
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		for (i in menuTexts)
		{
			if (FlxG.mouse.overlaps(i))
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
