package basic 
{
	import org.flixel.*;
	import flash.utils.ByteArray;
    /**
     * Embeds and imports all assets for the game
     * @author Cody Sandahl
     */
	public class Assets 
	{
		// object
		[Embed(source = "../assets/sprites/armor (opengameart - Redshrike - ccby30).png")] public static var ARMOR_SPRITE:Class;
		[Embed(source = "../assets/sprites/axe_hang (opengameart - Redshrike - ccby30).png")] public static var AXEHANG_SPRITE:Class;
		[Embed(source = "../assets/sprites/bed (opengameart - Redshrike - ccby30).png")] public static var BED_SPRITE:Class;
		[Embed(source = "../assets/sprites/bookcase (opengameart - Redshrike - ccby30).png")] public static var BOOKCASE_SPRITE:Class;
		[Embed(source = "../assets/sprites/bookcase_side (opengameart - Redshrike - ccby30).png")] public static var BOOKCASESIDE_SPRITE:Class;
		[Embed(source = "../assets/sprites/chair_down (opengameart - Redshrike - ccby30).png")] public static var CHAIRDOWN_SPRITE:Class;
		[Embed(source = "../assets/sprites/chair_left (opengameart - Redshrike - ccby30).png")] public static var CHAIRLEFT_SPRITE:Class;
		[Embed(source = "../assets/sprites/chair_right (opengameart - Redshrike - ccby30).png")] public static var CHAIRRIGHT_SPRITE:Class;
		[Embed(source = "../assets/sprites/chair_up (opengameart - Redshrike - ccby30).png")] public static var CHAIRUP_SPRITE:Class;
		[Embed(source = "../assets/sprites/rug1 (opengameart - Redshrike - ccby30).png")] public static var RUG1_SPRITE:Class;
		[Embed(source = "../assets/sprites/rug2 (opengameart - Redshrike - ccby30).png")] public static var RUG2_SPRITE:Class;
		[Embed(source = "../assets/sprites/sword_hang (opengameart - Redshrike - ccby30).png")] public static var SWORDHANG_SPRITE:Class;
		[Embed(source = "../assets/sprites/table_rectangle (opengameart - Redshrike - ccby30).png")] public static var TABLERECTANGLE_SPRITE:Class;
		[Embed(source = "../assets/sprites/table_round (opengameart - Redshrike - ccby30).png")] public static var TABLEROUND_SPRITE:Class;
		[Embed(source = "../assets/sprites/torch (opengameart - Redshrike - ccby30).png")] public static var TORCH_SPRITE:Class;
		
		// character
		[Embed(source = "../assets/sprites/warrior_weapon (opengameart - Antifarea - ccby30).png")] public static var WARRIOR_SPRITE:Class;
		[Embed(source = "../assets/sprites/warrior_head.png")] public static var WARRIOR_HEAD:Class;
		[Embed(source = "../assets/sprites/ninja.png")] public static var NINJA_SRPITE:Class;
		
		// enemy
		[Embed(source="../assets/sprites/goblin (opengameart - Redshrike - ccby30).png")] public static var GOBLIN_SPRITE:Class
		
		// weapon
		[Embed(source = "../assets/sprites/sword1.png")] public static var SWORD1_SPRITE:Class;
		[Embed(source = "../assets/sprites/katana.png")] public static var KATANA_SPRITE:Class;
		
		// spell
		[Embed(source = "../assets/sprites/spell_swordwave.png")] public static var SPELL_SWORDWAVE:Class;
		
		// tiles
		[Embed(source = "../assets/tiles/floor_wood (opengameart - Redshrike - ccby30).png")] public static var FLOORS_TILE:Class;
		[Embed(source = "../assets/tiles/walls (opengameart - Redshrike - ccby30).png")] public static var WALLS_TILE:Class;
		
		// UI
		[Embed(source = "../assets/sprites/emptybar.png")] public static var EMPTYBAR:Class;
		[Embed(source = "../assets/sprites/healthbar.png")] public static var HEALTHBAR:Class;
		[Embed(source = "../assets/sprites/manabar.png")] public static var MANABAR:Class;
		[Embed(source = "../assets/sprites/staminabar.png")] public static var STAMINABAR:Class;
		[Embed(source = "../assets/sprites/ragebar.png")] public static var RAGEBAR:Class;
		[Embed(source="../assets/sprites/char_ui.png")] public static var CHAR_UI:Class
		
	}

}