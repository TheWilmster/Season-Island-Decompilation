#region Check if runtime is correct
#macro PROJECT_RUNTIME "2024.13.1.242"
#macro PROJECT_RUNTIME_TYPE "gms2"
 
if (GM_runtime_version != PROJECT_RUNTIME) {
    var str = string_concat(
        "Warning: Your GameMaker runtime version doesn't match the decompile's intended runtime.\n",
        "\nYour runtime: ", GM_runtime_version, " (", GM_runtime_type, " runtime)",
        "\nRequired runtime: ", PROJECT_RUNTIME, " (", PROJECT_RUNTIME_TYPE, " runtime)",
        "\n\nPlease switch runtimes, or if you're porting it to a different runtime, change the PROJECT_RUNTIME macro."
    );
    show_message(str);
    game_end();
}
#endregion

#region 3D Constants
#macro RAD pi/180

enum UV_Data {
    Left            = 0,
    Top             = 1,
    Right           = 2,
    Bottom          = 3,
    TrimLeft        = 4,
    TrimTop         = 5,
    WidthPercent    = 6,
    HeightPerecent  = 7
}
#endregion

#region General Enums
enum SoundType {
    Single,
    Multiple
}

enum Chapters {
    Spring = 1,
    
    //Speculation
    Summer = 2,
    Fall   = 3,
    Winter = 4
}

enum Seasons {
    Spring = 0,
    
    //Speculation
    Summer = 1,
    Fall   = 2,
    Winter = 3
}

enum Event {
    KillerScene           = 0,
    KillerDefeat          = 1,
    MetSpring             = 2,
    EnterTreehouseOutside = 3,
    MetNewton             = 4,
    TreehouseBranchesCut  = 5,
    EnterTreehouse        = 6,
    EnterNewtonShop       = 7,
    SpringDateStart       = 8,
    EnterTeahouse         = 9,
    ListSize              = 10,
}

enum ItemType {
    None               = -1,
    TopiaryShears      = 0,
    WoodenBranch       = 1,
    WateringCan        = 2,
    WateringCanFull    = 3,
    WateringCanBroken  = 4,
    Vine               = 5,
    Slingshot          = 6,
    
    Item7              = 7,    // Unused.
    
    Crinoid            = 8,
    SuperiorShears     = 9,
    LegendaryShears    = 10,
    BigCrinoid         = 11,
    
    Item12             = 12,   // Unused.
    
    Stepladder         = 13,
    StepladderBroken   = 14,
    Hammer             = 15,
    Nails              = 16,
    SmallCogs          = 17,
    GiantCog           = 18,
    WateringCanOil     = 19,
    Pipe               = 20,
    LoveLetter         = 21,
    LoveLetterWet      = 22,
}

enum Actor {
    Spike     = 0,
    Newton    = 1,
    Spring    = 2,
    Tere      = 3,
}

enum AnimeEffect {
    Blush     = 0,
    Hearts    = 1,
    Anger     = 2,
    Worry     = 3,
    Sweat     = 4,
}

enum Depth {
    Cursor    = -9500,
    Popup     = -9450,
    Textbox   = -9150,
    Fade      = -9100,
    Particle  = -9080,
    ButtonUI  = -9070,
    InvItem   = -9060,
    Inventory = -9050,
    Menu      = -9040,
    TBDisplay = -9030,
    Actor     = -9020,
}

enum NewtonAd {
    Apple     = 0,
}
#endregion

#region Unused constants. Most likely from the RPG era of season island.
global.__color_wheel_val = []; // No idea how to make this array, lmao.

#macro TILE_SIZE 16
#macro DIR 0
#macro SPD 1
#macro COLOR_WHEEL global.__color_wheel_val
enum FACE {
    LEFT,
    UP,
    RIGHT,
    DOWN
}
#endregion
