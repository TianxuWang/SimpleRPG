package basic
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * Base class for all levels
	 * @author Tianxu Wang
	 */
	public class Level extends FlxGroup
	{
		/**
         * Map
         */
        public var state:FlxState; // state displaying the level
        public var levelSize:FlxPoint; // width and height of level (in pixels)
        public var tileSize:FlxPoint; // default width and height of each tile (in pixels)
        public var numTiles:FlxPoint; // how many tiles are in this level (width and height)
        public var floorGroup:FlxGroup; // floor (rendered beneath the walls - no collisions)
        public var wallGroup:FlxGroup; // all the map blocks (with collisions)
        public var guiGroup:FlxGroup; // gui elements	
		
		/**
         * Player
         */
        public var player:Player;
        public var playerStart:FlxPoint = new FlxPoint(120, 120);
		
		public var weapon:Weapon;
		public var bulletGroup:FlxGroup;
		public var enemyGroup:FlxGroup;
		public var BarGroup:FlxGroup;
		public var battleMsgGroup:FlxGroup
		
		/**
         * Constructor
         * @param   state       State displaying the level
         * @param   levelSize   Width and height of level (in pixels)
         * @param   tileSize   Default width and height of each tile (in pixels)
         */
        public function Level(state:FlxState, levelSize:FlxPoint, tileSize:FlxPoint):void 
		{
            super();
            this.state = state;
            this.levelSize = levelSize;
            this.tileSize = tileSize;
            if (levelSize && tileSize)
                this.numTiles = new FlxPoint(Math.floor(levelSize.x / tileSize.x), Math.floor(levelSize.y / tileSize.y));
            // setup groups
            this.floorGroup = new FlxGroup();
            this.wallGroup = new FlxGroup();
            this.guiGroup = new FlxGroup();
			this.enemyGroup = new FlxGroup();
			this.bulletGroup = new FlxGroup();
			this.BarGroup = new FlxGroup();
			this.battleMsgGroup = new FlxGroup();
            // create the level
            this.create();
        }
		
		public function create():void 
		{
			createMap();
            createPlayer();
			createEnemy();
			createWeapon();
			createBullet();
			createBar();
			createBattleMsg();
            createGUI();
            addGroups();
            createCamera();
		}
		
		/**
         * Create the map (walls, decals, etc)
         */
        protected function createMap():void
		{
			
        }
		
		/**
         * Create the player, bullets, etc
         */
		protected function createPlayer():void 
		{
			player = new Entity(playerStart.x, playerStart.y) as Player;
		}
		
		protected function createWeapon():void
		{
			weapon = new Weapon(playerStart.x, playerStart.y);
		}
		
		protected function createEnemy():void 
		{
			
		}
		
		protected function createBullet():void 
		{
			
		}
		
		/**
         * Create text, buttons, indicators, etc
         */
		protected function createGUI():void 
		{
			
		}
		
		protected function createBar():void 
		{
			
		}
		
		protected function createBattleMsg():void 
		{
			
		}
		
		/**
         * Decide the order of the groups. They are rendered in the order they're added, so last added is always on top.
         */
        protected function addGroups():void 
		{
            add(floorGroup);
            add(wallGroup);
            add(player);
			add(enemyGroup);
			add(weapon);
			add(bulletGroup);
			add(BarGroup);
			add(battleMsgGroup);
            add(guiGroup);
        }
		
		/**
         * Create the default camera for this level
         */
        protected function createCamera():void 
		{
            FlxG.worldBounds = new FlxRect(0, 0, levelSize.x, levelSize.y);
            FlxG.camera.setBounds(0, 0, levelSize.x, levelSize.y, true);
            FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
        }
		
		/**
         * Update each timestep
         */
        override public function update():void 
		{
            super.update();
            FlxG.collide(wallGroup, player);
        }
	}
}