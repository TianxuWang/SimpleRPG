package  
{
	import Enemy.Goblin;
	import org.flixel.*;
	import basic.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class IndoorHouseLevel extends Level
	{	
		/**
		 * Floor layer
		 */
		protected static var FLOORS:Array = new Array(
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		);
		
		/**
		 * Wall layer
		 */
		protected static var WALLS:Array = new Array(
			1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7,
			2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
		);
		
		/**
		 * Custom groups
		 */
		protected var decalGroup:FlxGroup; // extra decorative elements (no collisions)
		protected var objectGroup:FlxGroup; // objects and obstacles (with collisions)
		 
		/**
		 * Game objects
		 */
		protected var bookcase:FlxSprite;
		protected var armor:FlxSprite;
		protected var table:FlxSprite;
		protected var bed:FlxSprite;
		
		// UI
		protected var char_panel:FlxSprite;
		protected var char_head:FlxSprite;
		
		/**
		 * Constructor
		 * @param   state       State displaying the level
		 * @param   levelSize   Width and height of level (in pixels)
		 * @param   blockSize   Default width and height of each tile (in pixels)
		 */
		public function IndoorHouseLevel(state:FlxState, levelSize:FlxPoint, tileSize:FlxPoint):void 
		{
			super(state, levelSize, tileSize);
		}
		
		/**
		 * Create the map (walls, decals, etc)
		 */
		override protected function createMap():void {
			var tiles:FlxTilemap;
			// floor
			tiles = new FlxTilemap();
			tiles.loadMap(
				FlxTilemap.arrayToCSV(FLOORS, 20), // convert our array of tile indices to a format flixel understands
				Assets.FLOORS_TILE, // image to use
				tileSize.x, // width of each tile (in pixels)
				tileSize.y, // height of each tile (in pixels)
				0, // don't use auto tiling (needed so we can change the rest of these values)
				0, // starting index for our tileset (0 = include everything in the image)
				0, // starting index for drawing our tileset (0 = every tile is drawn)
				uint.MAX_VALUE // which tiles allow collisions by default (uint.MAX_VALUE = no collisions)
			);
			floorGroup.add(tiles);
			// walls
			// FFV: make left/right walls' use custom collision rects
			tiles = new FlxTilemap();
			tiles.loadMap(
				FlxTilemap.arrayToCSV(WALLS, 20), // convert our array of tile indices to a format flixel understands
				Assets.WALLS_TILE, // image to use
				tileSize.x, // width of each tile (in pixels)
				tileSize.y // height of each tile (in pixels)
			);
			wallGroup.add(tiles);
			// objects
			createObjects();
		}
		
		/**
		 * Add all the objects, obstacles, etc to the level
		 */
		protected function createObjects():void {
			var sprite:FlxSprite;
			// create custom groups
			decalGroup = new FlxGroup();
			objectGroup = new FlxGroup();
			// decals (decorative elements that have no functionality)
			sprite = new FlxSprite(
				16, // x location
				16, // y location
				Assets.RUG1_SPRITE // image to use
			);
			decalGroup.add(sprite);
			 
			sprite = new FlxSprite(
				11 * tileSize.x, // x location (using tileSize to align it with a tile)
				1.5 * tileSize.y, // y location (showing that you don't need to line up with a tile)
				Assets.RUG2_SPRITE // image to use
			);
			decalGroup.add(sprite);
			// objects and obstacles
			// NOTE: this group gets tested for collisions
			bookcase = new FlxSprite(
				32, // x location
				0, // y location (showing that you can overlap with the walls if you want)
				Assets.BOOKCASE_SPRITE // image to use
			);
			bookcase.immovable = true; // don't allow the player to move this object
			objectGroup.add(bookcase);
			 
			table = new FlxSprite(192, 192, Assets.TABLEROUND_SPRITE);
			table.immovable = true;
			objectGroup.add(table);
			 
			sprite = new FlxSprite(176, 192, Assets.CHAIRRIGHT_SPRITE);
			sprite.immovable = true;
			objectGroup.add(sprite);
			 
			sprite = new FlxSprite(216, 192, Assets.CHAIRLEFT_SPRITE);
			sprite.immovable = true;
			objectGroup.add(sprite);
			 
			armor = new FlxSprite(192, 0, Assets.ARMOR_SPRITE);
			armor.immovable = true;
			objectGroup.add(armor);
			 
			bed = new FlxSprite(16, 192, Assets.BED_SPRITE);
			bed.immovable = true;
			objectGroup.add(bed);
		}	
		
		override protected function createPlayer():void 
		{
			player = new Player(playerStart.x, playerStart.y, Assets.NINJA_SRPITE, FlxObject.DOWN);
			Registry.player = player as Player;
		}
		
		override protected function createWeapon():void 
		{
			weapon = WeaponFactory.createKatana(100, 100, Registry.player);
			player.weapon = weapon;
			Registry.weapon = player.weapon;
		}
		
		override protected function createBullet():void 
		{
			player._swordWave.bullets = new FlxWeapon("sword_wave", player, "x", "y");
		}
		
		override protected function createEnemy():void 
		{
			enemyGroup.add(new Goblin(240, 120, FlxObject.RIGHT));
			enemyGroup.add(new Goblin(256, 102, FlxObject.DOWN));
			enemyGroup.add(new Goblin(272, 120, FlxObject.LEFT));
			enemyGroup.add(new Goblin(256, 138, FlxObject.UP));
			Registry.enemyGroup = enemyGroup;
		}
		
		override protected function createBar():void 
		{
			player.healthBar = new FlxBar(53, 20, FlxBar.FILL_RIGHT_TO_LEFT, 64, 3, player, "health");
			player.healthBar.createImageBar(Assets.EMPTYBAR, Assets.HEALTHBAR);
			
			player.rageBar = new FlxBar(53, 30, FlxBar.FILL_RIGHT_TO_LEFT, 64, 3, player, "rage");
			player.rageBar.createImageBar(Assets.EMPTYBAR, Assets.RAGEBAR);
			
			player.staminaBar = new FlxBar(53, 40, FlxBar.FILL_RIGHT_TO_LEFT, 64, 3, player, "stamina");
			player.staminaBar.createImageBar(Assets.EMPTYBAR, Assets.STAMINABAR);

			BarGroup.add(player.healthBar);
			BarGroup.add(player.rageBar);
			BarGroup.add(player.staminaBar);
			
			for each(var enemy:Enemy in enemyGroup.members) {
				enemy.healthBar = new FlxBar(32, 16, FlxBar.FILL_LEFT_TO_RIGHT, 14, 2, enemy, "health");
				enemy.healthBar.trackParent(1, -4);
				BarGroup.add(enemy.healthBar);
			}
		}
		
		override protected function createBattleMsg():void 
		{
			player.battleMsg = new FlxText(player.x, player.y - 8, 32);
			player.battleMsg.color = 0xffff0000;
			player.battleMsg.size = 6;
			battleMsgGroup.add(player.battleMsg);
			
			for each(var enemy:Enemy in enemyGroup.members) {
				enemy.battleMsg = new FlxText(enemy.x, enemy.y - 8, 32);
				enemy.battleMsg.color = 0xffff0000;
				enemy.battleMsg.size = 6;
				battleMsgGroup.add(enemy.battleMsg);
			}	
		}
		
		override protected function createGUI():void 
		{
			char_head = new FlxSprite(21, 18);
			char_head.loadGraphic(Assets.WARRIOR_HEAD, false, false, 24, 25);
			char_panel = new FlxSprite(16, 16);
			char_panel.loadGraphic(Assets.CHAR_UI, false, false, 100, 32);
			guiGroup.add(char_head);
			guiGroup.add(char_panel);
		}
		
		override protected function addGroups():void
		{
			add(floorGroup);
			add(wallGroup);
			add(decalGroup);
			add(objectGroup);
			add(player);
			add(enemyGroup);
			add(weapon);
			add(bulletGroup);
			add(BarGroup);
			add(battleMsgGroup);
			add(guiGroup);
		}
		 
		override public function update():void 
		{
			super.update();
			
			FlxG.collide(objectGroup, player);
			
			FlxG.collide(wallGroup, enemyGroup);
			FlxG.collide(objectGroup, enemyGroup);
			FlxG.collide(enemyGroup, enemyGroup);
			
			Helper.checkRealCollide([player], enemyGroup.members, onCollidePlayerEnemy);
			//FlxG.collide(player, enemyGroup);
			Helper.checkRealCollide([weapon], enemyGroup.members, onCollideWeaponEnemy);
			
		}
		
		private function onCollidePlayerEnemy(_player:FlxSprite, _enemy:FlxSprite):void 
		{
			FlxObject.separate(_player, _enemy);
			_player.x = _player.last.x;
			_player.y = _player.last.y;
			_enemy.x = _enemy.last.x;
			_enemy.y = _enemy.last.y;
		}
		
		public function onCollideWeaponEnemy(_object:FlxSprite, _enemy:Enemy):void
		{
			if (_enemy.status != Entity.HURTING)
				_enemy.hitByWeapon(player);		
		}
	}
}