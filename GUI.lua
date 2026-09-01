--[[
    		Compkiller Interface

    Author: 4lpaca
    Modified & Optimized by: Toava
    Discord: Toava
    License: MIT
    Github: https://github.com/4lpaca-pin/CompKiller
    Original: compkiller.net

        Version: 3.0 (Toava Edition)
    - Embedded Custom Metallic V Logo (Zero web dependencies)
    - O(1) Icon Query Memoization Cache (_GetIcon)
    - Removed game.Changed listener memory leak in _Blur
    - High-Speed Random String Generation & Cached Power Rounding
    - Optimized Tween Pipeline with PerformanceMode Bypass
    - Text Bounds & Window Scale Optimizations
--]]

--- Export Types ---

export type cloneref = (target: Instance) -> Instance;

export type Window = {
	Name: string,
	Keybind: string | Enum.KeyCode,
	Logo: string,
	Scale: UDim2,
	TextSize: number
};

export type ConfigManager = {
	Directory: string,
	Config: string,
};

export type WriteConfig = {
	Name: string,
	Author: string,
};

export type WindowUpdate = {
	Username: string,
	ExpireDate: string,
	Logo: string,
	WindowName: string,
	UserProfile: string
};

export type ConfigFunctions = {
	Directory: string,
	WriteConfig: (self: ConfigFunctions , Config: WriteConfig) -> any?,
	ReadInfo: (self: ConfigFunctions , ConfigName: string) -> any?,
	DeleteConfig: (self: ConfigFunctions , ConfigName: string) -> any?,
	LoadConfig: (self: ConfigFunctions , ConfigName: string) -> any?,
	GetConfigs: (self: ConfigFunctions , ConfigName: string) -> {string},
	GetConfigCount: (self: ConfigFunctions) -> number,
	GetFullConfigs: (self: ConfigFunctions , ConfigName: string) -> {
		{
			Name: string,
			Info: {
				Type: string,
				Author: string,
				Name: string,
				CreatedDate: string,
			}
		}	
	},
};

export type KeybindSettings = {
	Key : string,
	On : boolean | number,
	Off : boolean | number,
	Mode : number,
	Name : string,
}

export type SecurityConfig = {
	BlurEnabled : boolean,
	ImageScale: number,
};

export type Notify = {
	Icon: string,
	Title: string,
	Content: string,
	Duration: number
};

export type NotifyPayback = {
	SetProgress: (self: Notify , time: number) -> any?,
	Content: (self: Notify , str: string) -> any?,
	Title: (self: Notify , str: string) -> any?,
	Close: () -> any?,
}

export type Watermark = {
	Icon: string,
	Text: string
};

export type TabConfig = {
	Name: string,
	Icon: string,
	Type: string,
	EnableScrolling: boolean
};

export type TabConfigManager = {
	Name: string,
	Icon: string,
	Config: ConfigFunctions
}

export type ContainerTab = {
	Name: string,
	Icon: string,
	EnableScrolling: boolean
};

export type Category = {
	Name: string
};

export type Section = {
	Name: string,
	Position: string
};

export type Toggle = {
	Name: string,
	Default: boolean,
	Flag: string | nil,
	Risky: boolean,
	Callback: (Value: boolean) -> any?
};

export type MiniToggle = {
	Default: boolean,
	Flag: string | nil,
	Callback: (Value: boolean) -> any?
};

export type TextBoxConfig = {
	Name: string,
	Default: string,
	Placeholder: string,
	Flag: string | nil,
	Numeric: boolean,
	Callback: (Text: string) -> any?
};

export type ColorPicker = {
	Name: string,
	Default: Color3,
	Flag: string | nil,
	Transparency: number,
	Callback: (Value: Color3 , Trans: number) -> any?
};

export type MiniColorPicker = {
	Default: Color3,
	Transparency: number,
	Flag: string | nil,
	Callback: (Value: Color3 , Trans: number) -> any?
};

export type Slider = {
	Name: string,
	Min: number,
	Max: number,
	Default: number,
	Type: string,
	Round: number,
	Callback: (Value: number) -> any?
};

export type Dropdown = {
	Name: string,
	Default: string | {string},
	Values: {string},
	Multi: boolean,
	Callback: (Value: string | {[string]: boolean}) -> any?
};

export type Button = {
	Name: string,
	Callback: () -> any?
};

export type Keybind = {
	Name: string,
	Default: string | Enum.KeyCode,
	Callback: (Value: string) -> any,
	Blacklist: {string | Enum.KeyCode}
};

export type MiniKeybind = {
	Default: string | Enum.KeyCode,
	Callback: (Value: string) -> any,
	Blacklist: {string | Enum.KeyCode}
};

export type Helper = {
	Text: string
};

export type Paragraph = {
	Title: string,
	Content: string
}

pcall(function() -- for Luraph
	local Constant = table.concat({"LP","H_NO"}).."_VI".."RTU".."AL".."IZE";
	getfenv()[Constant] = getfenv()[Constant] or function(f) return f end; 
	-- LPH_NO_VIRTUALIZE
end);

pcall(function() -- for IB1
	local Constant = "IB".."_NO_VI".."RTU".."AL".."IZE";
	getfenv()[Constant] = getfenv()[Constant] or function(f) return f end; 
	-- IB_NO_VIRTUALIZE
end);

getgenv = getgenv or getfenv;

-- Please ignore the ugly code. [Custom File System] --
if game:GetService('RunService'):IsStudio() then
	local BaseWorkspace = Instance.new('Folder',game:GetService("ReplicatedFirst"));

	BaseWorkspace.Name = tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)));

	local __get_path_c = function(path)
		return (string.find(path,'/',1,true) and string.split(path,'/')) or (string.find(path,'\\',1,true) and string.split(path,'\\')) or {path};
	end;

	local __get_path = function(path)
		local main = __get_path_c(path);

		local block = BaseWorkspace;

		for i,v in next , main do
			block = block[v];
		end;

		return block;
	end;

	getgenv().readfile = function(path)
		local path : StringValue = __get_path(path);

		return path.Value;
	end;

	getgenv().isfile = function(path)
		local success , message = pcall(function()
			return __get_path(path);
		end);

		if success and not message:IsA("Folder") then
			return true;
		end;

		return false;
	end;

	getgenv().isfolder = function(path)
		local success , message = pcall(function()
			return __get_path(path);
		end);

		if success and message:IsA("Folder") then
			return true;
		end;

		return false;
	end;

	getgenv().writefile = function(path,content)
		local main = __get_path_c(path);

		local block = BaseWorkspace;

		for i,v in next , main do
			local item = block:FindFirstChild(v);
			if not item then
				local c = Instance.new('StringValue',block);

				c.Name = tostring(v);
				c.Value = content;
			else
				if item:IsA('StringValue') and tostring(item) == v then
					item.Name = tostring(v);
					item.Value = content;
				end;

				block = item;
			end;
		end;
	end;

	getgenv().listfiles = function(path)
		local fold = __get_path(path);
		local pa = {};

		for i,v in next , fold:GetChildren() do
			if v:IsA('StringValue') then
				table.insert(pa,path..'/'..tostring(v));
			end;
		end;

		return pa;
	end;

	getgenv().makefolder = function(path)
		local main = __get_path_c(path);

		local block = BaseWorkspace;

		for i,v in next , main do
			local item = block:FindFirstChild(v);
			if not item then
				local c = Instance.new('Folder',block);

				c.Name = tostring(v);
			else
				block = item;
			end;
		end;
	end;

	getgenv().delfile = function(path)
		local main = __get_path_c(path);

		local block = BaseWorkspace;

		for i,v in next , main do
			local item = block:FindFirstChild(v);
			if item and item:IsA('StringValue') then
				item:Destroy();
			else
				block = item;
			end;
		end;
	end;
end;

--- Local Variables ---
local cloneref: cloneref = cloneref or function(f) return f end;
local TweenService: TweenService = cloneref(game:GetService('TweenService'));
local UserInputService: UserInputService = cloneref(game:GetService('UserInputService'));
local TextService: TextService = cloneref(game:GetService('TextService'));
local RunService: RunService = cloneref(game:GetService('RunService'));
local Players: Players = cloneref(game:GetService('Players'));
local HttpService: HttpService = cloneref(game:GetService('HttpService'));
local LocalPlayer: Player = Players.LocalPlayer;
local CoreGui: PlayerGui = (gethui and gethui()) or (get_hidden_gui and get_hidden_gui()) or cloneref(game:FindFirstChild('CoreGui')) or cloneref(LocalPlayer.PlayerGui);
local Mouse: Mouse = LocalPlayer:GetMouse();
local CurrentCamera: Camera? = cloneref(workspace.CurrentCamera);

local Compkiller = {
	Version = '3.0',
    -- Custom Metallic V Logo
    Logo = (function()
        local fileName = "toava_logo.png"
        local b64Data = "iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAACPJElEQVR4nO39d7ydVZ02jK9y911PL+m9ExJCL4Gh2UBQQUdlxjYwNnB0lHnmcQyMM2NhUAFFwYKiICZIb6ElEEJCCum955yT09uud1trvZ9r7b1jEvB53+f5vL/fH78fSw8nZ59z732Xtb7rW67r+hLy3nhvvDfeG++N98Z7473x3nhvvDfeG++N98Z7473x3vj/77FkyRL2bq8rpSghBF+nDlr93V87hvx/+pj/k6GU+qvv97+6B/+75/1/esz/7nv97w7j1De+7bbb6O233y7x9W43gVL6rq/j7yml73rT/r91zF8bt912m6p+p/9PP+e2225T1d/RJUuW0P+NY1TtPv7vHPP/xnvV7s9fex3f8X54X/K/Gm+88UbqN7/5zd/ceOON5qm/e+bxZ85YtWpV3Ttef+aZut/+9rdnvNv7Pfnkk+evXbs2ferrK1asaPzd73634N2OefTRR8/fsGGDd+rrq1evbn788cfnkf+XxtKlSyc998orU97td0899dQF1113HT/19fvvv3/6o48+Ou3U15VSbPny5ee/23vde++9cx999NEJp76+YsUKY+nSpe9631566aVz3+31xx57bPrPf/7zaX/lety/ci3e9u3breqPxyeU/gdWlFKKvPbaa21hGLqe5zXs2bXr8v7BwRdc1x02TaEizmkwGsipU6dePm7cuN2EkKOccz3TSqWSEiIYu3fvwRm+77/COT/+AYVCQU2ePPnasWPHvsU578Ixvk+IaQoZBMHEAwcOTB4aGnrVtm0mhFA8imghNtXEiU2fmDRpykpCSLc+hhDCo0hEUTS7q6trQn9///Oe53Hf94lpmgrfE4kEnTlzJrEs6/gMx+uO45iHDh0yenp6ylEU6XNLcE5zYRi3tLScO3bCWJZQidVlu2wkzaTEMfXJemffoQMf27Nv15Ou6+ZxHN4/HA0lS7BFkyZNipuamjYVi0WOz5NSqnQ67XV2dn5o+/btz7quW8QxjuPoe+AlvcUTx08camlp2RrHMcfSNk0T1ix7+PDhS4/s3ftkuqkJ10dxPfl83pk7d+4VY8aMWT48PBxU34clEkz09ubOPHr0KO7fRsYYx33DMUIIo729vWXatGndQgi94sMwpDg3SmnLvn375PDwcMfXvva1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"
        
        if isfile and writefile and not isfile(fileName) then
            pcall(function()
                local b64decode = (syn and syn.crypt and syn.crypt.base64.decode) or (crypt and crypt.base64decode) or (base64_decode)
                if b64decode then
                    local raw = b64decode(b64Data)
                    if raw and #raw > 0 then
                        writefile(fileName, raw)
                    end
                end
            end)
        end
        
        return (isfile and isfile(fileName) and (getcustomasset or getsynasset)(fileName)) or "rbxthumb://type=Asset&id=104369921168014&w=420&h=420"
    end)(),
	Windows = {},
	Scale = {
		Window = UDim2.new(0, 485,0, 565),
		Mobile = UDim2.new(0, 450,0, 375),
		TabOpen = 185,
		TabClose = 85,
	},
	PerformanceMode = false,
	WindowsNil = {},
	NilFolder = Instance.new('Folder'),
	ArcylicParent = CurrentCamera,
	ProtectGui = protect_gui or protectgui or (syn and syn.protect_gui) or function(s) return s; end,
};

Compkiller.Colors = {
	Highlight = Color3.fromRGB(128, 128, 128),
	Toggle = Color3.fromRGB(100, 100, 100),
	Risky = Color3.fromRGB(255, 255, 0),
	BGDBColor = Color3.fromRGB(15, 15, 15),
	BlockColor = Color3.fromRGB(25, 25, 25),
	StrokeColor = Color3.fromRGB(45, 45, 45),
	SwitchColor = Color3.fromRGB(220, 220, 220),
	DropColor = Color3.fromRGB(30, 30, 30),
	MouseEnter = Color3.fromRGB(50, 50, 50),
	BlockBackground = Color3.fromRGB(20, 20, 20),
	LineColor = Color3.fromRGB(60, 60, 60),
	HighStrokeColor = Color3.fromRGB(70, 70, 70),
};

Compkiller.Elements = {
	Highlight = {},
	DropHighlight = {},
	Risky = {},
	BGDBColor = {},
	BlockColor = {},
	StrokeColor = {},
	SwitchColor = {},
	DropColor = {},
	BlockBackground = {},
	LineColor = {},
	HighStrokeColor = {},
};

Compkiller.DragBlacklist = {};
Compkiller.IaDrag = false;
Compkiller.LastDrag = tick();
Compkiller.Flags = {};

Compkiller.Lucide = {
	['lucide-mouse-2'] = "rbxassetid://10088146939",
	['lucide-internet'] = "rbxassetid://12785195438",
	['lucide-earth'] = "rbxassetid://115986292591138",
	['lucide-settings-3'] = "rbxassetid://14007344336",
	["lucide-accessibility"] = "rbxassetid://10709751939",
	["lucide-activity"] = "rbxassetid://10709752035",
	["lucide-air-vent"] = "rbxassetid://10709752131",
	["lucide-airplay"] = "rbxassetid://10709752254",
	["lucide-alarm-check"] = "rbxassetid://10709752405",
	["lucide-alarm-clock"] = "rbxassetid://10709752630",
	["lucide-alarm-clock-off"] = "rbxassetid://10709752508",
	["lucide-alarm-minus"] = "rbxassetid://10709752732",
	["lucide-alarm-plus"] = "rbxassetid://10709752825",
	["lucide-album"] = "rbxassetid://10709752906",
	["lucide-alert-circle"] = "rbxassetid://10709752996",
	["lucide-alert-octagon"] = "rbxassetid://10709753064",
	["lucide-alert-triangle"] = "rbxassetid://10709753149",
	["lucide-align-center"] = "rbxassetid://10709753570",
	["lucide-align-center-horizontal"] = "rbxassetid://10709753272",
	["lucide-align-center-vertical"] = "rbxassetid://10709753421",
	["lucide-align-end-horizontal"] = "rbxassetid://10709753692",
	["lucide-align-end-vertical"] = "rbxassetid://10709753808",
	["lucide-align-horizontal-distribute-center"] = "rbxassetid://10747779791",
	["lucide-align-horizontal-distribute-end"] = "rbxassetid://10747784534",
	["lucide-align-horizontal-distribute-start"] = "rbxassetid://10709754118",
	["lucide-align-horizontal-justify-center"] = "rbxassetid://10709754204",
	["lucide-align-horizontal-justify-end"] = "rbxassetid://10709754317",
	["lucide-align-horizontal-justify-start"] = "rbxassetid://10709754436",
	["lucide-align-horizontal-space-around"] = "rbxassetid://10709754590",
	["lucide-align-horizontal-space-between"] = "rbxassetid://10709754749",
	["lucide-align-justify"] = "rbxassetid://10709759610",
	["lucide-align-left"] = "rbxassetid://10709759764",
	["lucide-align-right"] = "rbxassetid://10709759895",
	["lucide-align-start-horizontal"] = "rbxassetid://10709760051",
	["lucide-align-start-vertical"] = "rbxassetid://10709760244",
	["lucide-align-vertical-distribute-center"] = "rbxassetid://10709760351",
	["lucide-align-vertical-distribute-end"] = "rbxassetid://10709760434",
	["lucide-align-vertical-distribute-start"] = "rbxassetid://10709760612",
	["lucide-align-vertical-justify-center"] = "rbxassetid://10709760814",
	["lucide-align-vertical-justify-end"] = "rbxassetid://10709761003",
	["lucide-align-vertical-justify-start"] = "rbxassetid://10709761176",
	["lucide-align-vertical-space-around"] = "rbxassetid://10709761324",
	["lucide-align-vertical-space-between"] = "rbxassetid://10709761434",
	["lucide-anchor"] = "rbxassetid://10709761530",
	["lucide-angry"] = "rbxassetid://10709761629",
	["lucide-annoyed"] = "rbxassetid://10709761722",
	["lucide-aperture"] = "rbxassetid://10709761813",
	["lucide-apple"] = "rbxassetid://10709761889",
	["lucide-archive"] = "rbxassetid://10709762233",
	["lucide-archive-restore"] = "rbxassetid://10709762058",
	["lucide-armchair"] = "rbxassetid://10709762327",
	["lucide-arrow-big-down"] = "rbxassetid://10747796644",
	["lucide-arrow-big-left"] = "rbxassetid://10709762574",
	["lucide-arrow-big-right"] = "rbxassetid://10709762727",
	["lucide-arrow-big-up"] = "rbxassetid://10709762879",
	["lucide-arrow-down"] = "rbxassetid://10709767827",
	["lucide-arrow-down-circle"] = "rbxassetid://10709763034",
	["lucide-arrow-down-left"] = "rbxassetid://10709767656",
	["lucide-arrow-down-right"] = "rbxassetid://10709767750",
	["lucide-arrow-left"] = "rbxassetid://10709768114",
	["lucide-arrow-left-circle"] = "rbxassetid://10709767936",
	["lucide-arrow-left-right"] = "rbxassetid://10709768019",
	["lucide-arrow-right"] = "rbxassetid://10709768347",
	["lucide-arrow-right-circle"] = "rbxassetid://10709768226",
	["lucide-arrow-up"] = "rbxassetid://10709768939",
	["lucide-arrow-up-circle"] = "rbxassetid://10709768432",
	["lucide-arrow-up-down"] = "rbxassetid://10709768538",
	["lucide-arrow-up-left"] = "rbxassetid://10709768661",
	["lucide-arrow-up-right"] = "rbxassetid://10709768787",
	["lucide-asterisk"] = "rbxassetid://10709769095",
	["lucide-at-sign"] = "rbxassetid://10709769286",
	["lucide-award"] = "rbxassetid://10709769406",
	["lucide-axe"] = "rbxassetid://10709769508",
	["lucide-axis-3d"] = "rbxassetid://10709769598",
	["lucide-baby"] = "rbxassetid://10709769732",
	["lucide-backpack"] = "rbxassetid://10709769841",
	["lucide-baggage-claim"] = "rbxassetid://10709769935",
	["lucide-banana"] = "rbxassetid://10709770005",
	["lucide-banknote"] = "rbxassetid://10709770178",
	["lucide-bar-chart"] = "rbxassetid://10709773755",
	["lucide-bar-chart-2"] = "rbxassetid://10709770317",
	["lucide-bar-chart-3"] = "rbxassetid://10709770431",
	["lucide-bar-chart-4"] = "rbxassetid://10709770560",
	["lucide-bar-chart-horizontal"] = "rbxassetid://10709773669",
	["lucide-barcode"] = "rbxassetid://10747360675",
	["lucide-baseline"] = "rbxassetid://10709773863",
	["lucide-bath"] = "rbxassetid://10709773963",
	["lucide-battery"] = "rbxassetid://10709774640",
	["lucide-battery-charging"] = "rbxassetid://10709774068",
	["lucide-battery-full"] = "rbxassetid://10709774206",
	["lucide-battery-low"] = "rbxassetid://10709774370",
	["lucide-battery-medium"] = "rbxassetid://10709774513",
	["lucide-beaker"] = "rbxassetid://10709774756",
	["lucide-bed"] = "rbxassetid://10709775036",
	["lucide-bed-double"] = "rbxassetid://10709774864",
	["lucide-bed-single"] = "rbxassetid://10709774968",
	["lucide-beer"] = "rbxassetid://10709775167",
	["lucide-bell"] = "rbxassetid://10709775704",
	["lucide-bell-minus"] = "rbxassetid://10709775241",
	["lucide-bell-off"] = "rbxassetid://10709775320",
	["lucide-bell-plus"] = "rbxassetid://10709775448",
	["lucide-bell-ring"] = "rbxassetid://10709775560",
	["lucide-bike"] = "rbxassetid://10709775894",
	["lucide-binary"] = "rbxassetid://10709776050",
	["lucide-bitcoin"] = "rbxassetid://10709776126",
	["lucide-bluetooth"] = "rbxassetid://10709776655",
	["lucide-bluetooth-connected"] = "rbxassetid://10709776240",
	["lucide-bluetooth-off"] = "rbxassetid://10709776344",
	["lucide-bluetooth-searching"] = "rbxassetid://10709776501",
	["lucide-bold"] = "rbxassetid://10747813908",
	["lucide-bomb"] = "rbxassetid://10709781460",
	["lucide-bone"] = "rbxassetid://10709781605",
	["lucide-book"] = "rbxassetid://10709781824",
	["lucide-book-open"] = "rbxassetid://10709781717",
	["lucide-bookmark"] = "rbxassetid://10709782154",
	["lucide-bookmark-minus"] = "rbxassetid://10709781919",
	["lucide-bookmark-plus"] = "rbxassetid://10709782044",
	["lucide-bot"] = "rbxassetid://10709782230",
	["lucide-box"] = "rbxassetid://10709782497",
	["lucide-box-select"] = "rbxassetid://10709782342",
	["lucide-boxes"] = "rbxassetid://10709782582",
	["lucide-briefcase"] = "rbxassetid://10709782662",
	["lucide-brush"] = "rbxassetid://10709782758",
	["lucide-bug"] = "rbxassetid://10709782845",
	["lucide-building"] = "rbxassetid://10709783051",
	["lucide-building-2"] = "rbxassetid://10709782939",
	["lucide-bus"] = "rbxassetid://10709783137",
	["lucide-cake"] = "rbxassetid://10709783217",
	["lucide-calculator"] = "rbxassetid://10709783311",
	["lucide-calendar"] = "rbxassetid://10709789505",
	["lucide-calendar-check"] = "rbxassetid://10709783474",
	["lucide-calendar-check-2"] = "rbxassetid://10709783392",
	["lucide-calendar-clock"] = "rbxassetid://10709783577",
	["lucide-calendar-days"] = "rbxassetid://10709783673",
	["lucide-calendar-heart"] = "rbxassetid://10709783835",
	["lucide-calendar-minus"] = "rbxassetid://10709783959",
	["lucide-calendar-off"] = "rbxassetid://10709788784",
	["lucide-calendar-plus"] = "rbxassetid://10709788937",
	["lucide-calendar-range"] = "rbxassetid://10709789053",
	["lucide-calendar-search"] = "rbxassetid://10709789200",
	["lucide-calendar-x"] = "rbxassetid://10709789407",
	["lucide-calendar-x-2"] = "rbxassetid://10709789329",
	["lucide-camera"] = "rbxassetid://10709789686",
	["lucide-camera-off"] = "rbxassetid://10747822677",
	["lucide-car"] = "rbxassetid://10709789810",
	["lucide-carrot"] = "rbxassetid://10709789960",
	["lucide-cast"] = "rbxassetid://10709790097",
	["lucide-charge"] = "rbxassetid://10709790202",
	["lucide-check"] = "rbxassetid://10709790644",
	["lucide-check-circle"] = "rbxassetid://10709790387",
	["lucide-check-circle-2"] = "rbxassetid://10709790298",
	["lucide-check-square"] = "rbxassetid://10709790537",
	["lucide-chef-hat"] = "rbxassetid://10709790757",
	["lucide-cherry"] = "rbxassetid://10709790875",
	["lucide-chevron-down"] = "rbxassetid://10709790948",
	["lucide-chevron-first"] = "rbxassetid://10709791015",
	["lucide-chevron-last"] = "rbxassetid://10709791130",
	["lucide-chevron-left"] = "rbxassetid://10709791281",
	["lucide-chevron-right"] = "rbxassetid://10709791437",
	["lucide-chevron-up"] = "rbxassetid://10709791523",
	["lucide-chevrons-down"] = "rbxassetid://10709796864",
	["lucide-chevrons-down-up"] = "rbxassetid://10709791632",
	["lucide-chevrons-left"] = "rbxassetid://10709797151",
	["lucide-chevrons-left-right"] = "rbxassetid://10709797006",
	["lucide-chevrons-right"] = "rbxassetid://10709797382",
	["lucide-chevrons-right-left"] = "rbxassetid://10709797274",
	["lucide-chevrons-up"] = "rbxassetid://10709797622",
	["lucide-chevrons-up-down"] = "rbxassetid://10709797508",
	["lucide-chrome"] = "rbxassetid://10709797725",
	["lucide-circle"] = "rbxassetid://10709798174",
	["lucide-circle-dot"] = "rbxassetid://10709797837",
	["lucide-circle-ellipsis"] = "rbxassetid://10709797985",
	["lucide-circle-slashed"] = "rbxassetid://10709798100",
	["lucide-citrus"] = "rbxassetid://10709798276",
	["lucide-clapperboard"] = "rbxassetid://10709798350",
	["lucide-clipboard"] = "rbxassetid://10709799288",
	["lucide-clipboard-check"] = "rbxassetid://10709798443",
	["lucide-clipboard-copy"] = "rbxassetid://10709798574",
	["lucide-clipboard-edit"] = "rbxassetid://10709798682",
	["lucide-clipboard-list"] = "rbxassetid://10709798792",
	["lucide-clipboard-signature"] = "rbxassetid://10709798890",
	["lucide-clipboard-type"] = "rbxassetid://10709798999",
	["lucide-clipboard-x"] = "rbxassetid://10709799124",
	["lucide-clock"] = "rbxassetid://10709805144",
	["lucide-clock-1"] = "rbxassetid://10709799535",
	["lucide-clock-10"] = "rbxassetid://10709799718",
	["lucide-clock-11"] = "rbxassetid://10709799818",
	["lucide-clock-12"] = "rbxassetid://10709799962",
	["lucide-clock-2"] = "rbxassetid://10709803876",
	["lucide-clock-3"] = "rbxassetid://10709803989",
	["lucide-clock-4"] = "rbxassetid://10709804164",
	["lucide-clock-5"] = "rbxassetid://10709804291",
	["lucide-clock-6"] = "rbxassetid://10709804435",
	["lucide-clock-7"] = "rbxassetid://10709804599",
	["lucide-clock-8"] = "rbxassetid://10709804784",
	["lucide-clock-9"] = "rbxassetid://10709804996",
	["lucide-cloud"] = "rbxassetid://10709806740",
	["lucide-cloud-cog"] = "rbxassetid://10709805262",
	["lucide-cloud-drizzle"] = "rbxassetid://10709805371",
	["lucide-cloud-fog"] = "rbxassetid://10709805477",
	["lucide-cloud-hail"] = "rbxassetid://10709805596",
	["lucide-cloud-lightning"] = "rbxassetid://10709805727",
	["lucide-cloud-moon"] = "rbxassetid://10709805942",
	["lucide-cloud-moon-rain"] = "rbxassetid://10709805838",
	["lucide-cloud-off"] = "rbxassetid://10709806060",
	["lucide-cloud-rain"] = "rbxassetid://10709806277",
	["lucide-cloud-rain-wind"] = "rbxassetid://10709806166",
	["lucide-cloud-snow"] = "rbxassetid://10709806374",
	["lucide-cloud-sun"] = "rbxassetid://10709806631",
	["lucide-cloud-sun-rain"] = "rbxassetid://10709806475",
	["lucide-cloudy"] = "rbxassetid://10709806859",
	["lucide-clover"] = "rbxassetid://10709806995",
	["lucide-code"] = "rbxassetid://10709810463",
	["lucide-code-2"] = "rbxassetid://10709807111",
	["lucide-codepen"] = "rbxassetid://10709810534",
	["lucide-codesandbox"] = "rbxassetid://10709810676",
	["lucide-coffee"] = "rbxassetid://10709810814",
	["lucide-cog"] = "rbxassetid://10709810948",
	["lucide-coins"] = "rbxassetid://10709811110",
	["lucide-columns"] = "rbxassetid://10709811261",
	["lucide-command"] = "rbxassetid://10709811365",
	["lucide-compass"] = "rbxassetid://10709811445",
	["lucide-component"] = "rbxassetid://10709811595",
	["lucide-concierge-bell"] = "rbxassetid://10709811706",
	["lucide-connection"] = "rbxassetid://10747361219",
	["lucide-contact"] = "rbxassetid://10709811834",
	["lucide-contrast"] = "rbxassetid://10709811939",
	["lucide-cookie"] = "rbxassetid://10709812067",
	["lucide-copy"] = "rbxassetid://10709812159",
	["lucide-copyleft"] = "rbxassetid://10709812251",
	["lucide-copyright"] = "rbxassetid://10709812311",
	["lucide-corner-down-left"] = "rbxassetid://10709812396",
	["lucide-corner-down-right"] = "rbxassetid://10709812485",
	["lucide-corner-left-down"] = "rbxassetid://10709812632",
	["lucide-corner-left-up"] = "rbxassetid://10709812784",
	["lucide-corner-right-down"] = "rbxassetid://10709812939",
	["lucide-corner-right-up"] = "rbxassetid://10709813094",
	["lucide-corner-up-left"] = "rbxassetid://10709813185",
	["lucide-corner-up-right"] = "rbxassetid://10709813281",
	["lucide-cpu"] = "rbxassetid://10709813383",
	["lucide-croissant"] = "rbxassetid://10709818125",
	["lucide-crop"] = "rbxassetid://10709818245",
	["lucide-cross"] = "rbxassetid://10709818399",
	["lucide-crosshair"] = "rbxassetid://10709818534",
	["lucide-crown"] = "rbxassetid://10709818626",
	["lucide-cup-soda"] = "rbxassetid://10709818763",
	["lucide-curly-braces"] = "rbxassetid://10709818847",
	["lucide-currency"] = "rbxassetid://10709818931",
	["lucide-database"] = "rbxassetid://10709818996",
	["lucide-delete"] = "rbxassetid://10709819059",
	["lucide-diamond"] = "rbxassetid://10709819149",
	["lucide-dice-1"] = "rbxassetid://10709819266",
	["lucide-dice-2"] = "rbxassetid://10709819361",
	["lucide-dice-3"] = "rbxassetid://10709819508",
	["lucide-dice-4"] = "rbxassetid://10709819670",
	["lucide-dice-5"] = "rbxassetid://10709819801",
	["lucide-dice-6"] = "rbxassetid://10709819896",
	["lucide-dices"] = "rbxassetid://10723343321",
	["lucide-diff"] = "rbxassetid://10723343416",
	["lucide-disc"] = "rbxassetid://10723343537",
	["lucide-divide"] = "rbxassetid://10723343805",
	["lucide-divide-circle"] = "rbxassetid://10723343636",
	["lucide-divide-square"] = "rbxassetid://10723343737",
	["lucide-dollar-sign"] = "rbxassetid://10723343958",
	["lucide-download"] = "rbxassetid://10723344270",
	["lucide-download-cloud"] = "rbxassetid://10723344088",
	["lucide-droplet"] = "rbxassetid://10723344432",
	["lucide-droplets"] = "rbxassetid://10734883356",
	["lucide-drumstick"] = "rbxassetid://10723344737",
	["lucide-edit"] = "rbxassetid://10734883598",
	["lucide-edit-2"] = "rbxassetid://10723344885",
	["lucide-edit-3"] = "rbxassetid://10723345088",
	["lucide-egg"] = "rbxassetid://10723345518",
	["lucide-egg-fried"] = "rbxassetid://10723345347",
	["lucide-electricity"] = "rbxassetid://10723345749",
	["lucide-electricity-off"] = "rbxassetid://10723345643",
	["lucide-equal"] = "rbxassetid://10723345990",
	["lucide-equal-not"] = "rbxassetid://10723345866",
	["lucide-eraser"] = "rbxassetid://10723346158",
	["lucide-euro"] = "rbxassetid://10723346372",
	["lucide-expand"] = "rbxassetid://10723346553",
	["lucide-external-link"] = "rbxassetid://10723346684",
	["lucide-eye"] = "rbxassetid://10723346959",
	["lucide-eye-off"] = "rbxassetid://10723346871",
	["lucide-factory"] = "rbxassetid://10723347051",
	["lucide-fan"] = "rbxassetid://10723354359",
	["lucide-fast-forward"] = "rbxassetid://10723354521",
	["lucide-feather"] = "rbxassetid://10723354671",
	["lucide-figma"] = "rbxassetid://10723354801",
	["lucide-file"] = "rbxassetid://10723374641",
	["lucide-file-archive"] = "rbxassetid://10723354921",
	["lucide-file-audio"] = "rbxassetid://10723355148",
	["lucide-file-audio-2"] = "rbxassetid://10723355026",
	["lucide-file-axis-3d"] = "rbxassetid://10723355272",
	["lucide-file-badge"] = "rbxassetid://10723355622",
	["lucide-file-badge-2"] = "rbxassetid://10723355451",
	["lucide-file-bar-chart"] = "rbxassetid://10723355887",
	["lucide-file-bar-chart-2"] = "rbxassetid://10723355746",
	["lucide-file-box"] = "rbxassetid://10723355989",
	["lucide-file-check"] = "rbxassetid://10723356210",
	["lucide-file-check-2"] = "rbxassetid://10723356100",
	["lucide-file-clock"] = "rbxassetid://10723356329",
	["lucide-file-code"] = "rbxassetid://10723356507",
	["lucide-file-cog"] = "rbxassetid://10723356830",
	["lucide-file-cog-2"] = "rbxassetid://10723356676",
	["lucide-file-diff"] = "rbxassetid://10723357039",
	["lucide-file-digit"] = "rbxassetid://10723357151",
	["lucide-file-down"] = "rbxassetid://10723357322",
	["lucide-file-edit"] = "rbxassetid://10723357495",
	["lucide-file-heart"] = "rbxassetid://10723357637",
	["lucide-file-image"] = "rbxassetid://10723357790",
	["lucide-file-input"] = "rbxassetid://10723357933",
	["lucide-file-json"] = "rbxassetid://10723364435",
	["lucide-file-json-2"] = "rbxassetid://10723364361",
	["lucide-file-key"] = "rbxassetid://10723364605",
	["lucide-file-key-2"] = "rbxassetid://10723364515",
	["lucide-file-line-chart"] = "rbxassetid://10723364725",
	["lucide-file-lock"] = "rbxassetid://10723364957",
	["lucide-file-lock-2"] = "rbxassetid://10723364861",
	["lucide-file-minus"] = "rbxassetid://10723365254",
	["lucide-file-minus-2"] = "rbxassetid://10723365086",
	["lucide-file-output"] = "rbxassetid://10723365457",
	["lucide-file-pie-chart"] = "rbxassetid://10723365598",
	["lucide-file-plus"] = "rbxassetid://10723365877",
	["lucide-file-plus-2"] = "rbxassetid://10723365766",
	["lucide-file-question"] = "rbxassetid://10723365987",
	["lucide-file-scan"] = "rbxassetid://10723366167",
	["lucide-file-search"] = "rbxassetid://10723366550",
	["lucide-file-search-2"] = "rbxassetid://10723366340",
	["lucide-file-signature"] = "rbxassetid://10723366741",
	["lucide-file-spreadsheet"] = "rbxassetid://10723366962",
	["lucide-file-symlink"] = "rbxassetid://10723367098",
	["lucide-file-terminal"] = "rbxassetid://10723367244",
	["lucide-file-text"] = "rbxassetid://10723367380",
	["lucide-file-type"] = "rbxassetid://10723367606",
	["lucide-file-type-2"] = "rbxassetid://10723367509",
	["lucide-file-up"] = "rbxassetid://10723367734",
	["lucide-file-video"] = "rbxassetid://10723373884",
	["lucide-file-video-2"] = "rbxassetid://10723367834",
	["lucide-file-volume"] = "rbxassetid://10723374172",
	["lucide-file-volume-2"] = "rbxassetid://10723374030",
	["lucide-file-warning"] = "rbxassetid://10723374276",
	["lucide-file-x"] = "rbxassetid://10723374544",
	["lucide-file-x-2"] = "rbxassetid://10723374378",
	["lucide-files"] = "rbxassetid://10723374759",
	["lucide-film"] = "rbxassetid://10723374981",
	["lucide-filter"] = "rbxassetid://10723375128",
	["lucide-fingerprint"] = "rbxassetid://10723375250",
	["lucide-flag"] = "rbxassetid://10723375890",
	["lucide-flag-off"] = "rbxassetid://10723375443",
	["lucide-flag-triangle-left"] = "rbxassetid://10723375608",
	["lucide-flag-triangle-right"] = "rbxassetid://10723375727",
	["lucide-flame"] = "rbxassetid://10723376114",
	["lucide-flashlight"] = "rbxassetid://10723376471",
	["lucide-flashlight-off"] = "rbxassetid://10723376365",
	["lucide-flask-conical"] = "rbxassetid://10734883986",
	["lucide-flask-round"] = "rbxassetid://10723376614",
	["lucide-flip-horizontal"] = "rbxassetid://10723376884",
	["lucide-flip-horizontal-2"] = "rbxassetid://10723376745",
	["lucide-flip-vertical"] = "rbxassetid://10723377138",
	["lucide-flip-vertical-2"] = "rbxassetid://10723377026",
	["lucide-flower"] = "rbxassetid://10747830374",
	["lucide-flower-2"] = "rbxassetid://10723377305",
	["lucide-focus"] = "rbxassetid://10723377537",
	["lucide-folder"] = "rbxassetid://10723387563",
	["lucide-folder-archive"] = "rbxassetid://10723384478",
	["lucide-folder-check"] = "rbxassetid://10723384605",
	["lucide-folder-clock"] = "rbxassetid://10723384731",
	["lucide-folder-closed"] = "rbxassetid://10723384893",
	["lucide-folder-cog"] = "rbxassetid://10723385213",
	["lucide-folder-cog-2"] = "rbxassetid://10723385036",
	["lucide-folder-down"] = "rbxassetid://10723385338",
	["lucide-folder-edit"] = "rbxassetid://10723385445",
	["lucide-folder-heart"] = "rbxassetid://10723385545",
	["lucide-folder-input"] = "rbxassetid://10723385721",
	["lucide-folder-key"] = "rbxassetid://10723385848",
	["lucide-folder-lock"] = "rbxassetid://10723386005",
	["lucide-folder-minus"] = "rbxassetid://10723386127",
	["lucide-folder-open"] = "rbxassetid://10723386277",
	["lucide-folder-output"] = "rbxassetid://10723386386",
	["lucide-folder-plus"] = "rbxassetid://10723386531",
	["lucide-folder-search"] = "rbxassetid://10723386787",
	["lucide-folder-search-2"] = "rbxassetid://10723386674",
	["lucide-folder-symlink"] = "rbxassetid://10723386930",
	["lucide-folder-tree"] = "rbxassetid://10723387085",
	["lucide-folder-up"] = "rbxassetid://10723387265",
	["lucide-folder-x"] = "rbxassetid://10723387448",
	["lucide-folders"] = "rbxassetid://10723387721",
	["lucide-form-input"] = "rbxassetid://10723387841",
	["lucide-forward"] = "rbxassetid://10723388016",
	["lucide-frame"] = "rbxassetid://10723394389",
	["lucide-framer"] = "rbxassetid://10723394565",
	["lucide-frown"] = "rbxassetid://10723394681",
	["lucide-fuel"] = "rbxassetid://10723394846",
	["lucide-function-square"] = "rbxassetid://10723395041",
	["lucide-gamepad"] = "rbxassetid://10723395457",
	["lucide-gamepad-2"] = "rbxassetid://10723395215",
	["lucide-gauge"] = "rbxassetid://10723395708",
	["lucide-gavel"] = "rbxassetid://10723395896",
	["lucide-gem"] = "rbxassetid://10723396000",
	["lucide-ghost"] = "rbxassetid://10723396107",
	["lucide-gift"] = "rbxassetid://10723396402",
	["lucide-gift-card"] = "rbxassetid://10723396225",
	["lucide-git-branch"] = "rbxassetid://10723396676",
	["lucide-git-branch-plus"] = "rbxassetid://10723396542",
	["lucide-git-commit"] = "rbxassetid://10723396812",
	["lucide-git-compare"] = "rbxassetid://10723396954",
	["lucide-git-fork"] = "rbxassetid://10723397049",
	["lucide-git-merge"] = "rbxassetid://10723397165",
	["lucide-git-pull-request"] = "rbxassetid://10723397431",
	["lucide-git-pull-request-closed"] = "rbxassetid://10723397268",
	["lucide-git-pull-request-draft"] = "rbxassetid://10734884302",
	["lucide-glass"] = "rbxassetid://10723397788",
	["lucide-glass-2"] = "rbxassetid://10723397529",
	["lucide-glass-water"] = "rbxassetid://10723397678",
	["lucide-glasses"] = "rbxassetid://10723397895",
	["lucide-globe"] = "rbxassetid://10723404337",
	["lucide-globe-2"] = "rbxassetid://10723398002",
	["lucide-grab"] = "rbxassetid://10723404472",
	["lucide-graduation-cap"] = "rbxassetid://10723404691",
	["lucide-grape"] = "rbxassetid://10723404822",
	["lucide-grid"] = "rbxassetid://10723404936",
	["lucide-grip-horizontal"] = "rbxassetid://10723405089",
	["lucide-grip-vertical"] = "rbxassetid://10723405236",
	["lucide-hammer"] = "rbxassetid://10723405360",
	["lucide-hand"] = "rbxassetid://10723405649",
	["lucide-hand-metal"] = "rbxassetid://10723405508",
	["lucide-hard-drive"] = "rbxassetid://10723405749",
	["lucide-hard-hat"] = "rbxassetid://10723405859",
	["lucide-hash"] = "rbxassetid://10723405975",
	["lucide-haze"] = "rbxassetid://10723406078",
	["lucide-headphones"] = "rbxassetid://10723406165",
	["lucide-heart"] = "rbxassetid://10723406885",
	["lucide-heart-crack"] = "rbxassetid://10723406299",
	["lucide-heart-handshake"] = "rbxassetid://10723406480",
	["lucide-heart-off"] = "rbxassetid://10723406662",
	["lucide-heart-pulse"] = "rbxassetid://10723406795",
	["lucide-help-circle"] = "rbxassetid://10723406988",
	["lucide-hexagon"] = "rbxassetid://10723407092",
	["lucide-highlighter"] = "rbxassetid://10723407192",
	["lucide-history"] = "rbxassetid://10723407335",
	["lucide-home"] = "rbxassetid://10723407389",
	["lucide-hourglass"] = "rbxassetid://10723407498",
	["lucide-ice-cream"] = "rbxassetid://10723414308",
	["lucide-image"] = "rbxassetid://10723415040",
	["lucide-image-minus"] = "rbxassetid://10723414487",
	["lucide-image-off"] = "rbxassetid://10723414677",
	["lucide-image-plus"] = "rbxassetid://10723414827",
	["lucide-import"] = "rbxassetid://10723415205",
	["lucide-inbox"] = "rbxassetid://10723415335",
	["lucide-indent"] = "rbxassetid://10723415494",
	["lucide-indian-rupee"] = "rbxassetid://10723415642",
	["lucide-infinity"] = "rbxassetid://10723415766",
	["lucide-info"] = "rbxassetid://10723415903",
	["lucide-inspect"] = "rbxassetid://10723416057",
	["lucide-italic"] = "rbxassetid://10723416195",
	["lucide-japanese-yen"] = "rbxassetid://10723416363",
	["lucide-joystick"] = "rbxassetid://10723416527",
	["lucide-key"] = "rbxassetid://10723416652",
	["lucide-keyboard"] = "rbxassetid://10723416765",
	["lucide-lamp"] = "rbxassetid://10723417513",
	["lucide-lamp-ceiling"] = "rbxassetid://10723416922",
	["lucide-lamp-desk"] = "rbxassetid://10723417016",
	["lucide-lamp-floor"] = "rbxassetid://10723417131",
	["lucide-lamp-wall-down"] = "rbxassetid://10723417240",
	["lucide-lamp-wall-up"] = "rbxassetid://10723417356",
	["lucide-landmark"] = "rbxassetid://10723417608",
	["lucide-languages"] = "rbxassetid://10723417703",
	["lucide-laptop"] = "rbxassetid://10723423881",
	["lucide-laptop-2"] = "rbxassetid://10723417797",
	["lucide-lasso"] = "rbxassetid://10723424235",
	["lucide-lasso-select"] = "rbxassetid://10723424058",
	["lucide-laugh"] = "rbxassetid://10723424372",
	["lucide-layers"] = "rbxassetid://10723424505",
	["lucide-layout"] = "rbxassetid://10723425376",
	["lucide-layout-dashboard"] = "rbxassetid://10723424646",
	["lucide-layout-grid"] = "rbxassetid://10723424838",
	["lucide-layout-list"] = "rbxassetid://10723424963",
	["lucide-layout-template"] = "rbxassetid://10723425187",
	["lucide-leaf"] = "rbxassetid://10723425539",
	["lucide-library"] = "rbxassetid://10723425615",
	["lucide-life-buoy"] = "rbxassetid://10723425685",
	["lucide-lightbulb"] = "rbxassetid://10723425852",
	["lucide-lightbulb-off"] = "rbxassetid://10723425762",
	["lucide-line-chart"] = "rbxassetid://10723426393",
	["lucide-link"] = "rbxassetid://10723426722",
	["lucide-link-2"] = "rbxassetid://10723426595",
	["lucide-link-2-off"] = "rbxassetid://10723426513",
	["lucide-list"] = "rbxassetid://10723433811",
	["lucide-list-checks"] = "rbxassetid://10734884548",
	["lucide-list-end"] = "rbxassetid://10723426886",
	["lucide-list-minus"] = "rbxassetid://10723426986",
	["lucide-list-music"] = "rbxassetid://10723427081",
	["lucide-list-ordered"] = "rbxassetid://10723427199",
	["lucide-list-plus"] = "rbxassetid://10723427334",
	["lucide-list-start"] = "rbxassetid://10723427494",
	["lucide-list-video"] = "rbxassetid://10723427619",
	["lucide-list-x"] = "rbxassetid://10723433655",
	["lucide-loader"] = "rbxassetid://10723434070",
	["lucide-loader-2"] = "rbxassetid://10723433935",
	["lucide-locate"] = "rbxassetid://10723434557",
	["lucide-locate-fixed"] = "rbxassetid://10723434236",
	["lucide-locate-off"] = "rbxassetid://10723434379",
	["lucide-lock"] = "rbxassetid://10723434711",
	["lucide-log-in"] = "rbxassetid://10723434830",
	["lucide-log-out"] = "rbxassetid://10723434906",
	["lucide-luggage"] = "rbxassetid://10723434993",
	["lucide-magnet"] = "rbxassetid://10723435069",
	["lucide-mail"] = "rbxassetid://10734885430",
	["lucide-mail-check"] = "rbxassetid://10723435182",
	["lucide-mail-minus"] = "rbxassetid://10723435261",
	["lucide-mail-open"] = "rbxassetid://10723435342",
	["lucide-mail-plus"] = "rbxassetid://10723435443",
	["lucide-mail-question"] = "rbxassetid://10723435515",
	["lucide-mail-search"] = "rbxassetid://10734884739",
	["lucide-mail-warning"] = "rbxassetid://10734885015",
	["lucide-mail-x"] = "rbxassetid://10734885247",
	["lucide-mails"] = "rbxassetid://10734885614",
	["lucide-map"] = "rbxassetid://10734886202",
	["lucide-map-pin"] = "rbxassetid://10734886004",
	["lucide-map-pin-off"] = "rbxassetid://10734885803",
	["lucide-maximize"] = "rbxassetid://10734886735",
	["lucide-maximize-2"] = "rbxassetid://10734886496",
	["lucide-medal"] = "rbxassetid://10734887072",
	["lucide-megaphone"] = "rbxassetid://10734887454",
	["lucide-megaphone-off"] = "rbxassetid://10734887311",
	["lucide-meh"] = "rbxassetid://10734887603",
	["lucide-menu"] = "rbxassetid://10734887784",
	["lucide-message-circle"] = "rbxassetid://10734888000",
	["lucide-message-square"] = "rbxassetid://10734888228",
	["lucide-mic"] = "rbxassetid://10734888864",
	["lucide-mic-2"] = "rbxassetid://10734888430",
	["lucide-mic-off"] = "rbxassetid://10734888646",
	["lucide-microscope"] = "rbxassetid://10734889106",
	["lucide-microwave"] = "rbxassetid://10734895076",
	["lucide-milestone"] = "rbxassetid://10734895310",
	["lucide-minimize"] = "rbxassetid://10734895698",
	["lucide-minimize-2"] = "rbxassetid://10734895530",
	["lucide-minus"] = "rbxassetid://10734896206",
	["lucide-minus-circle"] = "rbxassetid://10734895856",
	["lucide-minus-square"] = "rbxassetid://10734896029",
	["lucide-monitor"] = "rbxassetid://10734896881",
	["lucide-monitor-off"] = "rbxassetid://10734896360",
	["lucide-monitor-speaker"] = "rbxassetid://10734896512",
	["lucide-moon"] = "rbxassetid://10734897102",
	["lucide-more-horizontal"] = "rbxassetid://10734897250",
	["lucide-more-vertical"] = "rbxassetid://10734897387",
	["lucide-mountain"] = "rbxassetid://10734897956",
	["lucide-mountain-snow"] = "rbxassetid://10734897665",
	["lucide-mouse"] = "rbxassetid://10734898592",
	["lucide-mouse-pointer"] = "rbxassetid://10734898476",
	["lucide-mouse-pointer-2"] = "rbxassetid://10734898194",
	["lucide-mouse-pointer-click"] = "rbxassetid://10734898355",
	["lucide-move"] = "rbxassetid://10734900011",
	["lucide-move-3d"] = "rbxassetid://10734898756",
	["lucide-move-diagonal"] = "rbxassetid://10734899164",
	["lucide-move-diagonal-2"] = "rbxassetid://10734898934",
	["lucide-move-horizontal"] = "rbxassetid://10734899414",
	["lucide-move-vertical"] = "rbxassetid://10734899821",
	["lucide-music"] = "rbxassetid://10734905958",
	["lucide-music-2"] = "rbxassetid://10734900215",
	["lucide-music-3"] = "rbxassetid://10734905665",
	["lucide-music-4"] = "rbxassetid://10734905823",
	["lucide-navigation"] = "rbxassetid://10734906744",
	["lucide-navigation-2"] = "rbxassetid://10734906332",
	["lucide-navigation-2-off"] = "rbxassetid://10734906144",
	["lucide-navigation-off"] = "rbxassetid://10734906580",
	["lucide-network"] = "rbxassetid://10734906975",
	["lucide-newspaper"] = "rbxassetid://10734907168",
	["lucide-octagon"] = "rbxassetid://10734907361",
	["lucide-option"] = "rbxassetid://10734907649",
	["lucide-outdent"] = "rbxassetid://10734907933",
	["lucide-package"] = "rbxassetid://10734909540",
	["lucide-package-2"] = "rbxassetid://10734908151",
	["lucide-package-check"] = "rbxassetid://10734908384",
	["lucide-package-minus"] = "rbxassetid://10734908626",
	["lucide-package-open"] = "rbxassetid://10734908793",
	["lucide-package-plus"] = "rbxassetid://10734909016",
	["lucide-package-search"] = "rbxassetid://10734909196",
	["lucide-package-x"] = "rbxassetid://10734909375",
	["lucide-paint-bucket"] = "rbxassetid://10734909847",
	["lucide-paintbrush"] = "rbxassetid://10734910187",
	["lucide-paintbrush-2"] = "rbxassetid://10734910030",
	["lucide-palette"] = "rbxassetid://10734910430",
	["lucide-palmtree"] = "rbxassetid://10734910680",
	["lucide-paperclip"] = "rbxassetid://10734910927",
	["lucide-party-popper"] = "rbxassetid://10734918735",
	["lucide-pause"] = "rbxassetid://10734919336",
	["lucide-pause-circle"] = "rbxassetid://10735024209",
	["lucide-pause-octagon"] = "rbxassetid://10734919143",
	["lucide-pen-tool"] = "rbxassetid://10734919503",
	["lucide-pencil"] = "rbxassetid://10734919691",
	["lucide-percent"] = "rbxassetid://10734919919",
	["lucide-person-standing"] = "rbxassetid://10734920149",
	["lucide-phone"] = "rbxassetid://10734921524",
	["lucide-phone-call"] = "rbxassetid://10734920305",
	["lucide-phone-forwarded"] = "rbxassetid://10734920508",
	["lucide-phone-incoming"] = "rbxassetid://10734920694",
	["lucide-phone-missed"] = "rbxassetid://10734920845",
	["lucide-phone-off"] = "rbxassetid://10734921077",
	["lucide-phone-outgoing"] = "rbxassetid://10734921288",
	["lucide-pie-chart"] = "rbxassetid://10734921727",
	["lucide-piggy-bank"] = "rbxassetid://10734921935",
	["lucide-pin"] = "rbxassetid://10734922324",
	["lucide-pin-off"] = "rbxassetid://10734922180",
	["lucide-pipette"] = "rbxassetid://10734922497",
	["lucide-pizza"] = "rbxassetid://10734922774",
	["lucide-plane"] = "rbxassetid://10734922971",
	["lucide-play"] = "rbxassetid://10734923549",
	["lucide-play-circle"] = "rbxassetid://10734923214",
	["lucide-plus"] = "rbxassetid://10734924532",
	["lucide-plus-circle"] = "rbxassetid://10734923868",
	["lucide-plus-square"] = "rbxassetid://10734924219",
	["lucide-podcast"] = "rbxassetid://10734929553",
	["lucide-pointer"] = "rbxassetid://10734929723",
	["lucide-pound-sterling"] = "rbxassetid://10734929981",
	["lucide-power"] = "rbxassetid://10734930466",
	["lucide-power-off"] = "rbxassetid://10734930257",
	["lucide-printer"] = "rbxassetid://10734930632",
	["lucide-puzzle"] = "rbxassetid://10734930886",
	["lucide-quote"] = "rbxassetid://10734931234",
	["lucide-radio"] = "rbxassetid://10734931596",
	["lucide-radio-receiver"] = "rbxassetid://10734931402",
	["lucide-rectangle-horizontal"] = "rbxassetid://10734931777",
	["lucide-rectangle-vertical"] = "rbxassetid://10734932081",
	["lucide-recycle"] = "rbxassetid://10734932295",
	["lucide-redo"] = "rbxassetid://10734932822",
	["lucide-redo-2"] = "rbxassetid://10734932586",
	["lucide-refresh-ccw"] = "rbxassetid://10734933056",
	["lucide-refresh-cw"] = "rbxassetid://10734933222",
	["lucide-refrigerator"] = "rbxassetid://10734933465",
	["lucide-regex"] = "rbxassetid://10734933655",
	["lucide-repeat"] = "rbxassetid://10734933966",
	["lucide-repeat-1"] = "rbxassetid://10734933826",
	["lucide-reply"] = "rbxassetid://10734934252",
	["lucide-reply-all"] = "rbxassetid://10734934132",
	["lucide-rewind"] = "rbxassetid://10734934347",
	["lucide-rocket"] = "rbxassetid://10734934585",
	["lucide-rocking-chair"] = "rbxassetid://10734939942",
	["lucide-rotate-3d"] = "rbxassetid://10734940107",
	["lucide-rotate-ccw"] = "rbxassetid://10734940376",
	["lucide-rotate-cw"] = "rbxassetid://10734940654",
	["lucide-rss"] = "rbxassetid://10734940825",
	["lucide-ruler"] = "rbxassetid://10734941018",
	["lucide-russian-ruble"] = "rbxassetid://10734941199",
	["lucide-sailboat"] = "rbxassetid://10734941354",
	["lucide-save"] = "rbxassetid://10734941499",
	["lucide-scale"] = "rbxassetid://10734941912",
	["lucide-scale-3d"] = "rbxassetid://10734941739",
	["lucide-scaling"] = "rbxassetid://10734942072",
	["lucide-scan"] = "rbxassetid://10734942565",
	["lucide-scan-face"] = "rbxassetid://10734942198",
	["lucide-scan-line"] = "rbxassetid://10734942351",
	["lucide-scissors"] = "rbxassetid://10734942778",
	["lucide-screen-share"] = "rbxassetid://10734943193",
	["lucide-screen-share-off"] = "rbxassetid://10734942967",
	["lucide-scroll"] = "rbxassetid://10734943448",
	["lucide-search"] = "rbxassetid://10734943674",
	["lucide-send"] = "rbxassetid://10734943902",
	["lucide-separator-horizontal"] = "rbxassetid://10734944115",
	["lucide-separator-vertical"] = "rbxassetid://10734944326",
	["lucide-server"] = "rbxassetid://10734949856",
	["lucide-server-cog"] = "rbxassetid://10734944444",
	["lucide-server-crash"] = "rbxassetid://10734944554",
	["lucide-server-off"] = "rbxassetid://10734944668",
	["lucide-settings"] = "rbxassetid://10734950309",
	["lucide-settings-2"] = "rbxassetid://10734950020",
	["lucide-share"] = "rbxassetid://10734950813",
	["lucide-share-2"] = "rbxassetid://10734950553",
	["lucide-sheet"] = "rbxassetid://10734951038",
	["lucide-shield"] = "rbxassetid://10734951847",
	["lucide-shield-alert"] = "rbxassetid://10734951173",
	["lucide-shield-check"] = "rbxassetid://10734951367",
	["lucide-shield-close"] = "rbxassetid://10734951535",
	["lucide-shield-off"] = "rbxassetid://10734951684",
	["lucide-shirt"] = "rbxassetid://10734952036",
	["lucide-shopping-bag"] = "rbxassetid://10734952273",
	["lucide-shopping-cart"] = "rbxassetid://10734952479",
	["lucide-shovel"] = "rbxassetid://10734952773",
	["lucide-shower-head"] = "rbxassetid://10734952942",
	["lucide-shrink"] = "rbxassetid://10734953073",
	["lucide-shrub"] = "rbxassetid://10734953241",
	["lucide-shuffle"] = "rbxassetid://10734953451",
	["lucide-sidebar"] = "rbxassetid://10734954301",
	["lucide-sidebar-close"] = "rbxassetid://10734953715",
	["lucide-sidebar-open"] = "rbxassetid://10734954000",
	["lucide-sigma"] = "rbxassetid://10734954538",
	["lucide-signal"] = "rbxassetid://10734961133",
	["lucide-signal-high"] = "rbxassetid://10734954807",
	["lucide-signal-low"] = "rbxassetid://10734955080",
	["lucide-signal-medium"] = "rbxassetid://10734955336",
	["lucide-signal-zero"] = "rbxassetid://10734960878",
	["lucide-siren"] = "rbxassetid://10734961284",
	["lucide-skip-back"] = "rbxassetid://10734961526",
	["lucide-skip-forward"] = "rbxassetid://10734961809",
	["lucide-skull"] = "rbxassetid://10734962068",
	["lucide-slack"] = "rbxassetid://10734962339",
	["lucide-slash"] = "rbxassetid://10734962600",
	["lucide-slice"] = "rbxassetid://10734963024",
	["lucide-sliders"] = "rbxassetid://10734963400",
	["lucide-sliders-horizontal"] = "rbxassetid://10734963191",
	["lucide-smartphone"] = "rbxassetid://10734963940",
	["lucide-smartphone-charging"] = "rbxassetid://10734963671",
	["lucide-smile"] = "rbxassetid://10734964441",
	["lucide-smile-plus"] = "rbxassetid://10734964188",
	["lucide-snowflake"] = "rbxassetid://10734964600",
	["lucide-sofa"] = "rbxassetid://10734964852",
	["lucide-sort-asc"] = "rbxassetid://10734965115",
	["lucide-sort-desc"] = "rbxassetid://10734965287",
	["lucide-speaker"] = "rbxassetid://10734965419",
	["lucide-sprout"] = "rbxassetid://10734965572",
	["lucide-square"] = "rbxassetid://10734965702",
	["lucide-star"] = "rbxassetid://10734966248",
	["lucide-star-half"] = "rbxassetid://10734965897",
	["lucide-star-off"] = "rbxassetid://10734966097",
	["lucide-stethoscope"] = "rbxassetid://10734966384",
	["lucide-sticker"] = "rbxassetid://10734972234",
	["lucide-sticky-note"] = "rbxassetid://10734972463",
	["lucide-stop-circle"] = "rbxassetid://10734972621",
	["lucide-stretch-horizontal"] = "rbxassetid://10734972862",
	["lucide-stretch-vertical"] = "rbxassetid://10734973130",
	["lucide-strikethrough"] = "rbxassetid://10734973290",
	["lucide-subscript"] = "rbxassetid://10734973457",
	["lucide-sun"] = "rbxassetid://10734974297",
	["lucide-sun-dim"] = "rbxassetid://10734973645",
	["lucide-sun-medium"] = "rbxassetid://10734973778",
	["lucide-sun-moon"] = "rbxassetid://10734973999",
	["lucide-sun-snow"] = "rbxassetid://10734974130",
	["lucide-sunrise"] = "rbxassetid://10734974522",
	["lucide-sunset"] = "rbxassetid://10734974689",
	["lucide-superscript"] = "rbxassetid://10734974850",
	["lucide-swiss-franc"] = "rbxassetid://10734975024",
	["lucide-switch-camera"] = "rbxassetid://10734975214",
	["lucide-sword"] = "rbxassetid://10734975486",
	["lucide-swords"] = "rbxassetid://10734975692",
	["lucide-syringe"] = "rbxassetid://10734975932",
	["lucide-table"] = "rbxassetid://10734976230",
	["lucide-table-2"] = "rbxassetid://10734976097",
	["lucide-tablet"] = "rbxassetid://10734976394",
	["lucide-tag"] = "rbxassetid://10734976528",
	["lucide-tags"] = "rbxassetid://10734976739",
	["lucide-target"] = "rbxassetid://10734977012",
	["lucide-tent"] = "rbxassetid://10734981750",
	["lucide-terminal"] = "rbxassetid://10734982144",
	["lucide-terminal-square"] = "rbxassetid://10734981995",
	["lucide-text-cursor"] = "rbxassetid://10734982395",
	["lucide-text-cursor-input"] = "rbxassetid://10734982297",
	["lucide-thermometer"] = "rbxassetid://10734983134",
	["lucide-thermometer-snowflake"] = "rbxassetid://10734982571",
	["lucide-thermometer-sun"] = "rbxassetid://10734982771",
	["lucide-thumbs-down"] = "rbxassetid://10734983359",
	["lucide-thumbs-up"] = "rbxassetid://10734983629",
	["lucide-ticket"] = "rbxassetid://10734983868",
	["lucide-timer"] = "rbxassetid://10734984606",
	["lucide-timer-off"] = "rbxassetid://10734984138",
	["lucide-timer-reset"] = "rbxassetid://10734984355",
	["lucide-toggle-left"] = "rbxassetid://10734984834",
	["lucide-toggle-right"] = "rbxassetid://10734985040",
	["lucide-tornado"] = "rbxassetid://10734985247",
	["lucide-toy-brick"] = "rbxassetid://10747361919",
	["lucide-train"] = "rbxassetid://10747362105",
	["lucide-trash"] = "rbxassetid://10747362393",
	["lucide-trash-2"] = "rbxassetid://10747362241",
	["lucide-tree-deciduous"] = "rbxassetid://10747362534",
	["lucide-tree-pine"] = "rbxassetid://10747362748",
	["lucide-trees"] = "rbxassetid://10747363016",
	["lucide-trending-down"] = "rbxassetid://10747363205",
	["lucide-trending-up"] = "rbxassetid://10747363465",
	["lucide-triangle"] = "rbxassetid://10747363621",
	["lucide-trophy"] = "rbxassetid://10747363809",
	["lucide-truck"] = "rbxassetid://10747364031",
	["lucide-tv"] = "rbxassetid://10747364593",
	["lucide-tv-2"] = "rbxassetid://10747364302",
	["lucide-type"] = "rbxassetid://10747364761",
	["lucide-umbrella"] = "rbxassetid://10747364971",
	["lucide-underline"] = "rbxassetid://10747365191",
	["lucide-undo"] = "rbxassetid://10747365484",
	["lucide-undo-2"] = "rbxassetid://10747365359",
	["lucide-unlink"] = "rbxassetid://10747365771",
	["lucide-unlink-2"] = "rbxassetid://10747397871",
	["lucide-unlock"] = "rbxassetid://10747366027",
	["lucide-upload"] = "rbxassetid://10747366434",
	["lucide-upload-cloud"] = "rbxassetid://10747366266",
	["lucide-usb"] = "rbxassetid://10747366606",
	["lucide-user"] = "rbxassetid://10747373176",
	["lucide-user-check"] = "rbxassetid://10747371901",
	["lucide-user-cog"] = "rbxassetid://10747372167",
	["lucide-user-minus"] = "rbxassetid://10747372346",
	["lucide-user-plus"] = "rbxassetid://10747372702",
	["lucide-user-x"] = "rbxassetid://10747372992",
	["lucide-users"] = "rbxassetid://10747373426",
	["lucide-utensils"] = "rbxassetid://10747373821",
	["lucide-utensils-crossed"] = "rbxassetid://10747373629",
	["lucide-venetian-mask"] = "rbxassetid://10747374003",
	["lucide-verified"] = "rbxassetid://10747374131",
	["lucide-vibrate"] = "rbxassetid://10747374489",
	["lucide-vibrate-off"] = "rbxassetid://10747374269",
	["lucide-video"] = "rbxassetid://10747374938",
	["lucide-video-off"] = "rbxassetid://10747374721",
	["lucide-view"] = "rbxassetid://10747375132",
	["lucide-voicemail"] = "rbxassetid://10747375281",
	["lucide-volume"] = "rbxassetid://10747376008",
	["lucide-volume-1"] = "rbxassetid://10747375450",
	["lucide-volume-2"] = "rbxassetid://10747375679",
	["lucide-volume-x"] = "rbxassetid://10747375880",
	["lucide-wallet"] = "rbxassetid://10747376205",
	["lucide-wand"] = "rbxassetid://10747376565",
	["lucide-wand-2"] = "rbxassetid://10747376349",
	["lucide-watch"] = "rbxassetid://10747376722",
	["lucide-waves"] = "rbxassetid://10747376931",
	["lucide-webcam"] = "rbxassetid://10747381992",
	["lucide-wifi"] = "rbxassetid://10747382504",
	["lucide-wifi-off"] = "rbxassetid://10747382268",
	["lucide-wind"] = "rbxassetid://10747382750",
	["lucide-wrap-text"] = "rbxassetid://10747383065",
	["lucide-wrench"] = "rbxassetid://10747383470",
	["lucide-x"] = "rbxassetid://10747384394",
	["lucide-x-circle"] = "rbxassetid://10747383819",
	["lucide-x-octagon"] = "rbxassetid://10747384037",
	["lucide-x-square"] = "rbxassetid://10747384217",
	["lucide-zoom-in"] = "rbxassetid://10747384552",
	["lucide-zoom-out"] = "rbxassetid://10747384679",
};

Compkiller.FontAwesome = {
	a = "rbxassetid://74244459944328",
	['accessible-icon'] = "rbxassetid://135242143909610",
	accusoft = "rbxassetid://94057545767519",
	['address-book'] = "rbxassetid://129578640498728",
	['address-card'] = 'rbxassetid://102106715141928',
	['align-center'] = "rbxassetid://84408132800466",
	['align-justify'] = "rbxassetid://125569339749500",
	['align-left'] = "rbxassetid://110008004178539",
	['align-right'] = "rbxassetid://79774893981710",
	alipay = "rbxassetid://134274199490629",
	anchor = "rbxassetid://94979524088900",
	['anchor-circle-check'] = "rbxassetid://91871463373335",
	['anchor-circle-exclamation'] = "rbxassetid://72303311082053",
	['anchor-circle-xmark'] = "rbxassetid://106917001300524",
	['anchor-lock'] = "rbxassetid://109198662645391",
	android = "rbxassetid://93605821179752",
	['angle-down'] = "rbxassetid://122395101934469",
	['angle-left'] = "rbxassetid://132632410309959",
	['angle-right'] = "rbxassetid://105971664068240",
	['angles-down'] = "rbxassetid://96703500127872",
	['angles-left'] = "rbxassetid://70595546989447",
	['angles-right'] = "rbxassetid://131176182882747",
	['angles-up'] = "rbxassetid://96847020381396",
	['angle-up'] = "rbxassetid://136517226470297",
	['arrow-down'] = "rbxassetid://100174052036797",
	['arrow-left'] = "rbxassetid://133922718486450",
	['arrow-pointer'] = "rbxassetid://128639550333559",
	['arrow-right'] = 'rbxassetid://105166519175969',
	['arrow-right-arrow-left'] = "rbxassetid://87405428139040",
	['arrow-right-from-bracket'] = "rbxassetid://111722018253482",
	['arrow-right-to-bracket'] = "rbxassetid://79400903745367",
	['arrow-rotate-left'] = "rbxassetid://127876635051023",
	['arrow-rotate-right'] = "rbxassetid://82773599534347",
	['arrows-left-right'] = "rbxassetid://85625938291926",
	['arrows-rotate'] = "rbxassetid://109882153776270",
	['arrows-up-down'] = "rbxassetid://88240470530518",
	['arrows-up-down-left-right'] = "rbxassetid://136830364721572",
	['arrow-trend-down'] = "rbxassetid://138593805214121",
	['arrow-trend-up'] = "rbxassetid://121301107868410",
	['arrow-up'] = "rbxassetid://116473498857626",
	['arrow-up-from-bracket'] = "rbxassetid://77716847027695",
	['arrow-up-right-from-square'] = "rbxassetid://101883941536459",
	at = "rbxassetid://116468402170315",
	atom = "rbxassetid://136905279132440",
	['audio-description'] = 'rbxassetid://137490376195308',
	award = "rbxassetid://134322732056464",
	backward = "rbxassetid://115437448962693",
	['backward-fast'] = "rbxassetid://133478473989228",
	['backward-step'] = "rbxassetid://118301206125870",
	ban = "rbxassetid://89004310664420",
	bandage = "rbxassetid://109104902535966",
	bars = "rbxassetid://127661324755454",
	['bars-progress'] = "rbxassetid://77774174241071",
	['bars-staggered'] = "rbxassetid://97337529919486",
	baseball = "rbxassetid://87677782809968",
	basketball = "rbxassetid://71403045563776",
	['basket-shopping'] = "rbxassetid://129578273645224",
	['battery-empty'] = "rbxassetid://99777750808099",
	['battery-full'] = "rbxassetid://93999278270214",
	['battery-half'] = "rbxassetid://87762099115036",
	['battery-quarter'] = "rbxassetid://96680551535938",
	['battery-three-quarters'] = "rbxassetid://130840615974067",
	bell = "rbxassetid://109971903438934",
	['bell-slash'] = "rbxassetid://101758939103378",
	bilibili = "rbxassetid://85834752961243",
	biohazard = "rbxassetid://102610067899783",
	bitcoin = "rbxassetid://131632152157382",
	['bitcoin-sign'] = "rbxassetid://127809070259506",
	['bluetooth-b'] = "rbxassetid://96522278309021",
	bluetooth = "rbxassetid://113081372628241",
	bolt = "rbxassetid://89858717966393",
	bomb = "rbxassetid://113184250292244",
	book = "rbxassetid://134006112957521",
	['book-open'] = "rbxassetid://109774137257967",
	bug = "rbxassetid://105314179657552",
	['bug-slash'] = "rbxassetid://133973969610093",
	broom = "rbxassetid://95267009545395",
	bullhorn = "rbxassetid://87251830910561",
	['bullseye'] = "rbxassetid://83080500555400",
	bus = "rbxassetid://126579638968493",
	calculator = "rbxassetid://119527046782470",
	camera = "rbxassetid://133029797251962",
	['cc-amazon-pay'] = "rbxassetid://108859760370504",
	['cc-amex'] = "rbxassetid://138233598058785",
	['cc-apple-pay'] = "rbxassetid://133747941882534",
	['cc-diners-club'] = "rbxassetid://99626539664553",
	['cc-mastercard'] = "rbxassetid://118541621561504",
	['cc-visa'] = "rbxassetid://120055576031063",
	['cc-paypal'] = "rbxassetid://87250418163030",
	check = "rbxassetid://129443092324752",
	['chevron-down'] = "rbxassetid://109535175596957",
	['chevron-left'] = "rbxassetid://129113930144228",
	['chevron-right'] = "rbxassetid://105723602996553",
	['chevron-up'] = "rbxassetid://117264500851637",
	chromecast = "rbxassetid://71543589030583",
	circle = "rbxassetid://131274957777266",
	['circle-check'] = "rbxassetid://98678528147000",
	['circle-info'] = "rbxassetid://97519285421665",
	clipboard = 'rbxassetid://111512950362265',
	['clipboard-check'] = "rbxassetid://118535733506457",
	clock = "rbxassetid://98767608471295",
	code = "rbxassetid://91882036126433",
	['computer-mouse'] = "rbxassetid://114752565381440",
	cookie = "rbxassetid://101854685117513",
	copy = "rbxassetid://76996819137437",
	copyright = "rbxassetid://131736117717053",
	['credit-card'] = "rbxassetid://85213342061383",
	['crosshairs'] = "rbxassetid://133441774847498",
	database = "rbxassetid://109882554524389",
	discord = "rbxassetid://75871011309830",
	display = "rbxassetid://101851152220134",
	download = "rbxassetid://122321311031549",
	['earth-africa'] = "rbxassetid://107029199584204",
	['earth-americas'] = "rbxassetid://105574352653407",
	['earth-asia'] = "rbxassetid://138155660327900",
	['earth-europe'] = "rbxassetid://134638370907021",
	['earth-oceania'] = "rbxassetid://121780690380624",
	envelope = "rbxassetid://136184483524922",
	['envelope-open'] = "rbxassetid://132492127839357",
	envira = "rbxassetid://75781570526788",
	equals = "rbxassetid://134271902308970",
	eraser = "rbxassetid://128970640154301",
	ethereum = "rbxassetid://103421769879532",
	exclamation = "rbxassetid://125718656366676",
	eye = "rbxassetid://95235861336970",
	feather = "rbxassetid://135995843954302",
	fingerprint = "rbxassetid://125379360015007",
	fire = "rbxassetid://122498238725085",
	['floppy-disk'] = "rbxassetid://101374426361499",
	folder = "rbxassetid://131374292202389",
	['folder-open'] = "rbxassetid://78238714442180",
	forward = "rbxassetid://107937467448020",
	['forward-fast'] = "rbxassetid://83735840669276",
	['forward-step'] = "rbxassetid://104040171143566",
	gear = "rbxassetid://137945854328407",
	gift = "rbxassetid://129718366414314",
	git = "rbxassetid://117711060446092",
	github = "rbxassetid://123783733365919",
	globe = "rbxassetid://102861769355196",
	['hand-holding-hand'] = "rbxassetid://120797412134954",
	headphones = "rbxassetid://86076153665072",
	headset = "rbxassetid://108070801288944",
	['headphones-simple'] = "rbxassetid://97516570978183",
	house = "rbxassetid://86540166012974",
	['house-chimney'] = "rbxassetid://90066192203346",
	image = "rbxassetid://107205506080751",
	infinity = "rbxassetid://129024756905166",
	info = "rbxassetid://113157514619684",
	keyboard = "rbxassetid://97417417526948",
	list = "rbxassetid://87155993544457",
	['location-arrow'] = "rbxassetid://72621673664457",
	['location-crosshairs'] = "rbxassetid://93887450723164",
	lock = 'rbxassetid://80031239225283',
	palette = "rbxassetid://81372281623830",
	paste = "rbxassetid://88846256867074",
	paw = "rbxassetid://80005916079930",
	pen = "rbxassetid://97404859124912",
	pencil = "rbxassetid://76590960968733",
	['pen-nib'] = "rbxassetid://91232219924341",
	['pen-ruler'] = "rbxassetid://138407458813207",
	phone = "rbxassetid://72814141651992",
	plane = "rbxassetid://136248807279679",
	plus = "rbxassetid://133137619535544",
	['right-left'] = "rbxassetid://91273051324368",
	['right-to-bracket'] = "rbxassetid://137132451900886",
	rotate = "rbxassetid://95883878890200",
	['rotate-right'] = "rbxassetid://93357988077552",
	['rotate-left'] = "rbxassetid://96753646113822",
	shield = "rbxassetid://73441026473893",
	['shield-halved'] = "rbxassetid://114554606211174",
	user = "rbxassetid://98376828270066",
	unlock = "rbxassetid://99060354229117",
	trash = "rbxassetid://82859108629080",
	['trash-can'] = "rbxassetid://81463703129214",
	skull = "rbxassetid://99276754296574",
	robot = "rbxassetid://134497060038109",
	tag = "rbxassetid://129024358125754",
	thumbtack = "rbxassetid://119847869089109",
	['thumbs-up'] = "rbxassetid://74340984021785",
	['thumbs-down'] = "rbxassetid://86090492737223",
	['user-gear'] = "rbxassetid://137604201056497",
	video = "rbxassetid://112274059143251",
	virus = "rbxassetid://91843339206686",
	volleyball = "rbxassetid://73870192536894",
	['magnifying-glass'] = "rbxassetid://74387839235930",
};

function Compkiller:OptimizeMode(v)
	Compkiller.PerformanceMode = v;
end;

function Compkiller:IsStudio()
	return RunService:IsStudio()	
end;

function Compkiller:CustomIconHighlight()
	Compkiller.CustomHighlightMode = true;
end;

function Compkiller:_SetNilP(Ins: Instance , Parent: Instance)
	Compkiller.WindowsNil = Compkiller.WindowsNil or {};
	Compkiller.NilFolder = Compkiller.NilFolder or Instance.new('Folder');

	if not Compkiller.WindowsNil[Ins] then
		local win = Compkiller:_GetWindowFromElement(Ins);

		Compkiller.WindowsNil[Ins] = win;
	end;

	Ins.Parent = Parent or Compkiller.NilFolder;
end;

function Compkiller:SetAllText(flags : {[string] : string})
	if not flags then -- reset to default
		for i,v in next , Compkiller.Flags do
			if v.SetText then
				v:SetText(nil);
			end;
		end;

		return;
	end;

	flags = flags or {};

	for i,v in next , flags do
		if Compkiller.Flags[i] and Compkiller.Flags[i].SetText then
			Compkiller.Flags[i]:SetText(v);
		end;
	end;
end;

local _iconMemo = {};
function Compkiller:_GetIcon(name : string , font_aws) : string
	if not name or name == "" or name == "default" then return Compkiller.Logo end;
	local s_name = tostring(name);
	if string.find(s_name, "://", 1, true) or string.find(s_name, "http", 1, true) or #s_name > 36 then
		return name;
	end;

	local memoKey = (font_aws and "FA_" or "LU_") .. s_name;
	local cached = _iconMemo[memoKey];
	if cached then return cached end;

	local result = "";
	if Compkiller.SecureMode then
		local AssetId;
		if font_aws then
			AssetId = Compkiller.FontAwesome[name] or name;
		else
			AssetId = Compkiller.Lucide['lucide-'..s_name] or Compkiller.Lucide[name] or Compkiller.Lucide[s_name] or Compkiller.FontAwesome[name] or name;
		end;

		if AssetId and AssetId ~= nil then
			result = Compkiller:CacheImage(AssetId) or "";
		end;
	else
		if font_aws then
			result = Compkiller.FontAwesome[name] or name;
		else
			result = Compkiller.Lucide['lucide-'..s_name] or Compkiller.Lucide[name] or Compkiller.Lucide[s_name] or Compkiller.FontAwesome[name] or name;
		end;
	end;

	_iconMemo[memoKey] = result;
	return result;
end;

local _rndChars = {};
for i = 65, 90 do _rndChars[#_rndChars + 1] = string.char(i) end;
for i = 97, 122 do _rndChars[#_rndChars + 1] = string.char(i) end;
for i = 48, 57 do _rndChars[#_rndChars + 1] = string.char(i) end;
local _rndCount = #_rndChars;

function Compkiller:_RandomString() : string
	local buf = { "CK=" };
	for i = 2, 21 do
		buf[i] = _rndChars[math.random(1, _rndCount)];
	end;
	return table.concat(buf);
end;

function Compkiller:_IsMouseOverFrame(Frame : Frame) : boolean
	if not Frame then
		return;
	end;

	local AbsPos: Vector2, AbsSize: Vector2 = Frame.AbsolutePosition, Frame.AbsoluteSize;

	if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
		return true;
	end;
end;

local _pow10 = { [0] = 1, [1] = 10, [2] = 100, [3] = 1000, [4] = 10000, [5] = 100000 };
function Compkiller:_Rounding(num: number, numDecimalPlaces: number) : number
	local mult: number = _pow10[numDecimalPlaces or 0] or (10 ^ (numDecimalPlaces or 0));
	return math.floor(num * mult + 0.5) / mult;
end;

local _defaultTweenInfo = TweenInfo.new(0.25);
function Compkiller:_Animation(Self: Instance , Info: TweenInfo , Property :{[K] : V})
	if Compkiller.PerformanceMode then
		for prop, val in next, Property do
			pcall(function() Self[prop] = val end);
		end;
		return nil;
	end;

	local Tween = TweenService:Create(Self , Info or _defaultTweenInfo , Property);
	Tween:Play();
	return Tween;
end;

function Compkiller:_Input(Frame : Frame , Callback : () -> ()) : TextButton
	local Button = Instance.new('TextButton',Frame);

	Button.ZIndex = Frame.ZIndex + 10;
	Button.Size = UDim2.fromScale(1,1);
	Button.BackgroundTransparency = 1;
	Button.TextTransparency = 1;

	if Callback then
		Button.MouseButton1Click:Connect(Callback);
	end;

	return Button;
end;

function Compkiller:GetCalculatePosition(planePos: number, planeNormal: number, rayOrigin: number, rayDirection: number) : number
	local n = planeNormal;
	local d = rayDirection;
	local v = rayOrigin - planePos;

	local num = (n.x * v.x) + (n.y * v.y) + (n.z * v.z);
	local den = (n.x * d.x) + (n.y * d.y) + (n.z * d.z);
	local a = -num / den;

	return rayOrigin + (a * rayDirection);
end;

local _dummySignal = {
	Disconnect = function() end,
	disconnect = function() end,
	Connected = false
};
function Compkiller:_Blur(element : Frame , WindowRemote)
	return _dummySignal;
end;



function Compkiller:_AddDragBlacklist(Frame: Frame)
	local SET_BLACKLIST = function(value)
		local index = table.find(Compkiller.DragBlacklist , Frame);

		if value and not Compkiller.IS_DRAG_MOVE then
			if not index then
				table.insert(Compkiller.DragBlacklist,Frame);
			end;
		else
			if index then
				table.remove(Compkiller.DragBlacklist,index);
			end;
		end;
	end;

	Frame.MouseEnter:Connect(function()
		SET_BLACKLIST(true)
	end);

	Frame.MouseLeave:Connect(function()
		SET_BLACKLIST(false);
	end);
end;

function Compkiller:_GetWindowFromElement(Element)
	if Compkiller.WindowsNil[Element] then
		return Compkiller.WindowsNil[Element];
	end;

	for i,v : ScreenGui in next , Compkiller.Windows do
		if v and Element:IsDescendantOf(v) then
			return v;
		end;
	end;

	for Frame,Window in next , Compkiller.WindowsNil do
		if Element:IsDescendantOf(Frame) or Frame == Element then
			return Window;
		end;
	end;
end;

function Compkiller.__SIGNAL(default)
	local Bindable = Instance.new('BindableEvent');

	Bindable.Name = string.sub(tostring({}),7);

	Bindable:SetAttribute('Value',default);

	local Binds = {
		__signals = {}	
	};

	function Binds:Connect(event)
		event(Bindable:GetAttribute("Value"));

		local signal = Bindable.Event:Connect(event);

		table.insert(Binds.__signals,signal);

		return signal;
	end;

	function Binds:Fire(value)
		local IsSame = Bindable:GetAttribute("Value") == value;

		Bindable:SetAttribute('Value',value);

		if not IsSame then
			Bindable:Fire(value);
		end;
	end;

	function Binds:GetValue()
		return Bindable:GetAttribute("Value");
	end;

	return Binds;
end;

function Compkiller:_Hover(Frame: Frame , OnHover: () -> any?, Release: () -> any?)
	Frame.MouseEnter:Connect(OnHover);

	Frame.MouseLeave:Connect(Release);
end;

function Compkiller.__CONFIG(config , default)
	config = config or {};

	for i,v in next , default do
		if config[i] == nil then
			config[i] = v;
		end;
	end;

	return config;
end;

function Compkiller:Drag(InputFrame: Frame, MoveFrame: Frame, Speed : number)
	local dragToggle: boolean = false;
	local dragStart: Vector3 = nil;
	local startPos: UDim2 = nil;
	local dragConnection = nil;
	local endConnection = nil;
	local Tween = TweenInfo.new(Speed or 0);

	local updateInput = function(input)
		if not dragToggle or not MoveFrame.Visible then return end
		local CurrentScale = (Compkiller.MainUIScale and Compkiller.MainUIScale.Scale) or 1;
		local delta = (input.Position - dragStart) / CurrentScale;
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y);

		if Speed and Speed > 0 then
			Compkiller:_Animation(MoveFrame,Tween,{
				Position = position
			});
		else
			MoveFrame.Position = position
		end
	end;

	local function stopDrag()
		dragToggle = false
		Compkiller.IS_DRAG_MOVE = false
		Compkiller.IaDrag = false
		if dragConnection then
			dragConnection:Disconnect()
			dragConnection = nil
		end
		if endConnection then
			endConnection:Disconnect()
			endConnection = nil
		end
	end

	InputFrame.InputBegan:Connect(function(input)
		if not MoveFrame.Visible then return end
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and #Compkiller.DragBlacklist <= 0 then 
			dragToggle = true
			dragStart = input.Position
			startPos = MoveFrame.Position
			Compkiller.IaDrag = true
			Compkiller.LastDrag = tick()

			if dragConnection then dragConnection:Disconnect() end
			if endConnection then endConnection:Disconnect() end

			dragConnection = UserInputService.InputChanged:Connect(function(changedInput)
				if changedInput.UserInputType == Enum.UserInputType.MouseMovement or changedInput.UserInputType == Enum.UserInputType.Touch then
					if #Compkiller.DragBlacklist > 0 then
						stopDrag()
					else
						Compkiller.IS_DRAG_MOVE = true
						updateInput(changedInput)
					end
				end
			end)

			endConnection = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					stopDrag()
				end
			end)
		end
	end)
end;

function Compkiller:_IsMobile()
	return UserInputService.TouchEnabled;
end;

function Compkiller:_AddLinkValue(Name , Default , GlobalBlock , LinkValues , rep , Signal)
	if Name == "Toggle" then
		local Toggle = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ToggleValue = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")

		Toggle.Name = Compkiller:_RandomString()
		Toggle.Parent = LinkValues
		Toggle.BackgroundColor3 = Compkiller.Colors.DropColor
		Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.BorderSizePixel = 0
		Toggle.Size = UDim2.new(0, 30, 0, 16)
		Toggle.ZIndex = GlobalBlock.ZIndex + 1
		Toggle.LayoutOrder = -#LinkValues:GetChildren();

		table.insert(Compkiller.Elements.DropColor , {
			Element = Toggle,
			Property = "BackgroundColor3"
		})

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = Toggle

		UIStroke.Color = Compkiller.Colors.HighStrokeColor
		UIStroke.Parent = Toggle

		table.insert(Compkiller.Elements.HighStrokeColor,{
			Element = UIStroke,
			Property = "Color"
		})

		ToggleValue.Name = Compkiller:_RandomString()
		ToggleValue.Parent = Toggle
		ToggleValue.AnchorPoint = Vector2.new(0.5, 0.5)
		ToggleValue.BackgroundColor3 = Compkiller.Colors.SwitchColor
		ToggleValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ToggleValue.BorderSizePixel = 0
		ToggleValue.Position = UDim2.new(0.25, 0, 0.5, 0)
		ToggleValue.Size = UDim2.new(0.550000012, 0, 0.550000012, 0)
		ToggleValue.SizeConstraint = Enum.SizeConstraint.RelativeYY
		ToggleValue.ZIndex = GlobalBlock.ZIndex + 2

		UICorner_2.CornerRadius = UDim.new(1, 0)
		UICorner_2.Parent = ToggleValue;

		local ToggleElement = function(bool,noChange)
			if not noChange then
				Default = bool;
			end;

			if bool then
				Toggle:SetAttribute('Enabled',true);

				Compkiller:_Animation(ToggleValue,rep.Tween,{
					Position = UDim2.new(0.75, 0, 0.5, 0)
				})

				Compkiller:_Animation(Toggle,rep.Tween,{
					BackgroundColor3 = Compkiller.Colors.Toggle
				})
			else
				Toggle:SetAttribute('Enabled',false);

				Compkiller:_Animation(ToggleValue,rep.Tween,{
					Position = UDim2.new(0.25, 0, 0.5, 0)
				})

				Compkiller:_Animation(Toggle,rep.Tween,{
					BackgroundColor3 = Compkiller.Colors.DropColor
				})
			end;
		end;

		local Input = Compkiller:_Input(Toggle);

		Compkiller:_Hover(Input , function()
			if not Default then
				Compkiller:_Animation(ToggleValue,rep.Tween,{
					Size = UDim2.new(0.6, 0, 0.6, 0)
				})
			end;
		end , function()
			Compkiller:_Animation(ToggleValue,rep.Tween,{
				Size = UDim2.new(0.550000012, 0, 0.550000012, 0)
			})
		end);

		local ToggleUI = function(bool)
			if bool then
				ToggleElement(Default,true);

				Compkiller:_Animation(ToggleValue,rep.Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(Toggle,rep.Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(UIStroke,rep.Tween,{
					Transparency = 0
				})
			else
				ToggleElement(false,true);

				Compkiller:_Animation(ToggleValue,rep.Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(Toggle,rep.Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(UIStroke,rep.Tween,{
					Transparency = 1
				})
			end;
		end;

		ToggleElement(Default);

		Signal:Connect(ToggleUI)

		return {
			Root = Toggle,
			ChangeValue = ToggleElement,
			Input = Input,
			ToggleUI = ToggleUI,
		};
	elseif Name == "ColorPicker" then
		local ColorPicker = Instance.new("Frame")
		local ColorFrame = Instance.new("Frame")
		local UIScale = Instance.new("UIScale")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")

		ColorPicker.Name = Compkiller:_RandomString()
		ColorPicker.Parent = LinkValues
		ColorPicker.BackgroundTransparency = 1.000
		ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ColorPicker.BorderSizePixel = 0
		ColorPicker.Size = UDim2.new(0, 16, 0, 16)
		ColorPicker.ZIndex = GlobalBlock.ZIndex + 1
		ColorPicker.LayoutOrder = -#LinkValues:GetChildren();

		ColorFrame.Name = Compkiller:_RandomString()
		ColorFrame.Parent = ColorPicker
		ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		ColorFrame.BackgroundColor3 = Color3.fromRGB(15, 255, 207)
		ColorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ColorFrame.BorderSizePixel = 0
		ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		ColorFrame.Size = UDim2.new(1, -1, 1, -1)
		ColorFrame.ZIndex = GlobalBlock.ZIndex + 1

		UIScale.Parent = ColorFrame

		UIStroke.Color = Compkiller.Colors.HighStrokeColor
		UIStroke.Parent = ColorFrame

		table.insert(Compkiller.Elements.HighStrokeColor,{
			Element = UIStroke,
			Property = "Color"
		})

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = ColorFrame

		Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(ColorFrame,TweenInfo.new(0.15),{
					BackgroundTransparency = 0,
				})

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.15),{
					Transparency = 0,
				})
			else
				Compkiller:_Animation(ColorFrame,TweenInfo.new(0.15),{
					BackgroundTransparency = 1,
				})

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.15),{
					Transparency = 1,
				})
			end;
		end)

		Compkiller:_Hover(ColorPicker, function()
			if Signal:GetValue() then
				Compkiller:_Animation(UIScale,TweenInfo.new(0.35),{
					Scale = 1.2
				})
			end;
		end , function()
			if Signal:GetValue() then
				Compkiller:_Animation(UIScale,TweenInfo.new(0.35),{
					Scale = 1
				})
			end;
		end)

		return ColorPicker , ColorFrame;
	elseif Name == "Keybind" then
		local Keys = {
			One = '1',
			Two = '2',
			Three = '3',
			Four = '4',
			Five = '5',
			Six = '6',
			Seven = '7',
			Eight = '8',
			Nine = '9',
			Zero = '0',
			['Minus'] = "-",
			['Plus'] = "+",
			BackSlash = "\\",
			Slash = "/",
			Period = '.',
			Semicolon = ';',
			Colon = ":",
			LeftControl = "LCtrl",
			RightControl = "RCtrl",
			LeftShift = "LShift",
			RightShift = "RShift",
			Return = "Enter",
			LeftBracket = "[",
			RightBracket = "]",
			Quote = "'",
			Comma = ",",
			Equals = "=",
			LeftSuper = "Super",
			RightSuper = "Super",
			LeftAlt = "LAlt",
			RightAlt = "RAlt",
			Escape = "Esc",
		};

		local GetItem = function(item)
			if item then
				if typeof(item) == 'EnumItem' then
					return Keys[item.Name] or item.Name;
				else
					return Keys[tostring(item)] or tostring(item);
				end;
			else
				return 'None';
			end;
		end;

		local Keybind = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local TextLabel = Instance.new("TextLabel")

		Keybind.Name = Compkiller:_RandomString()
		Keybind.Parent = LinkValues
		Keybind.BackgroundColor3 = Compkiller.Colors.DropColor
		Keybind.BackgroundTransparency = 0.8
		Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Keybind.BorderSizePixel = 0
		Keybind.Size = UDim2.new(0, 45, 0, 16)
		Keybind.ZIndex = GlobalBlock.ZIndex + 2
		Keybind.ClipsDescendants = true
		Keybind.LayoutOrder = -#LinkValues:GetChildren();


		table.insert(Compkiller.Elements.DropColor , {
			Element = Keybind,
			Property = "BackgroundColor3"
		})

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = Keybind

		UIStroke.Color = Compkiller.Colors.HighStrokeColor
		UIStroke.Parent = Keybind

		table.insert(Compkiller.Elements.HighStrokeColor,{
			Element = UIStroke,
			Property = "Color"
		})

		TextLabel.Parent = Keybind
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, -5, 1, -5)
		TextLabel.ZIndex = GlobalBlock.ZIndex + 3
		TextLabel.Font = Enum.Font.Gotham
		TextLabel.Text = GetItem(Default or "None");
		TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TextLabel.TextSize = 12.000
		TextLabel.TextTransparency = 0.200

		table.insert(Compkiller.Elements.SwitchColor,{
			Element = TextLabel,
			Property = "TextColor3"
		});

		local Update = function()
			local size = TextService:GetTextSize(TextLabel.Text,TextLabel.TextSize,TextLabel.Font,Vector2.new(math.huge,math.huge));

			Compkiller:_Animation(Keybind,TweenInfo.new(0.1),{
				Size = UDim2.new(0, size.X + 5, 0, 16)
			});
		end;

		Update();

		local ToggleUI = function(bool)
			if bool then
				Compkiller:_Animation(Keybind,rep.Tween,{
					BackgroundTransparency = 0.8
				})

				Compkiller:_Animation(UIStroke,rep.Tween,{
					Transparency = 0
				})

				Compkiller:_Animation(TextLabel,rep.Tween,{
					TextTransparency = 0.200
				})
			else
				Compkiller:_Animation(Keybind,rep.Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(UIStroke,rep.Tween,{
					Transparency = 1
				})

				Compkiller:_Animation(TextLabel,rep.Tween,{
					TextTransparency = 1
				})
			end;
		end;

		Signal:Connect(ToggleUI);

		return {
			SetValue = function(text)
				TextLabel.Text = GetItem(text or "None");

				Update();
			end,
			Root = Keybind,
		};
	elseif Name == "Helper" then
		local InfoButton = Instance.new("ImageButton")
		local UICorner = Instance.new("UICorner")
		local BlockText = Instance.new("TextLabel")
		local UIStroke = Instance.new("UIStroke")
		local UICorner_2 = Instance.new("UICorner")

		InfoButton.Name = Compkiller:_RandomString()
		InfoButton.Parent = LinkValues
		InfoButton.BackgroundTransparency = 1.000
		InfoButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InfoButton.BorderSizePixel = 0
		InfoButton.LayoutOrder = -#LinkValues:GetChildren();
		InfoButton.Size = UDim2.new(0, 15, 0, 15)
		InfoButton.ZIndex = GlobalBlock.ZIndex + 25
		InfoButton.Image = Compkiller:CacheImage("rbxassetid://10723415903")
		InfoButton.ImageTransparency = 0.500

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = InfoButton

		BlockText.Name = Compkiller:_RandomString()
		BlockText.Parent = InfoButton
		BlockText.AnchorPoint = Vector2.new(0, 0)
		BlockText.BackgroundColor3 = Compkiller.Colors.BlockColor

		table.insert(Compkiller.Elements.BlockColor , {
			Element = BlockText,
			Property = "BackgroundColor3"
		});

		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 5, 0, 0)
		BlockText.Size = UDim2.new(0, 250, 0, 15)
		BlockText.ZIndex = GlobalBlock.ZIndex + 26
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = " "
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 13.000
		BlockText.TextTransparency = 0.300
		BlockText.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor,{
			Element = BlockText,
			Property = "TextColor3"
		});

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Parent = BlockText

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		UICorner_2.CornerRadius = UDim.new(0, 3)
		UICorner_2.Parent = BlockText

		Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(InfoButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.500
				})
			else
				Compkiller:_Animation(InfoButton,TweenInfo.new(0.15),{
					ImageTransparency = 1
				})
			end;
		end)

		Compkiller:_Hover(InfoButton, function()
			if Signal:GetValue() then
				Compkiller:_Animation(InfoButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.1
				})
			end;
		end , function()
			if Signal:GetValue() then
				Compkiller:_Animation(InfoButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.500
				})
			end;
		end)

		return {
			Text = BlockText,
			UIStroke = UIStroke,
			InfoButton = InfoButton,
		};
	elseif Name == "Option" then
		local OptionButton = Instance.new("ImageButton")
		local UICorner = Instance.new("UICorner")

		OptionButton.Name = Compkiller:_RandomString()
		OptionButton.Parent = LinkValues
		OptionButton.BackgroundTransparency = 1.000
		OptionButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		OptionButton.BorderSizePixel = 0
		OptionButton.Size = UDim2.new(0, 15, 0, 15)
		OptionButton.ZIndex = GlobalBlock.ZIndex + 2
		OptionButton.Image = Compkiller:CacheImage("rbxassetid://14007344336")
		OptionButton.ImageTransparency = 0.500
		OptionButton.LayoutOrder = -#LinkValues:GetChildren();

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = OptionButton

		Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(OptionButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.500
				})
			else
				Compkiller:_Animation(OptionButton,TweenInfo.new(0.15),{
					ImageTransparency = 1
				})
			end;
		end)

		Compkiller:_Hover(OptionButton, function()
			if Signal:GetValue() then
				Compkiller:_Animation(OptionButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.1
				})
			end;
		end , function()
			if Signal:GetValue() then
				Compkiller:_Animation(OptionButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.500
				})
			end;
		end)

		return OptionButton;
	end;
end;

function Compkiller:_CreateBlock(Signal)
	local GlobalBlock = Instance.new("Frame")
	local BlockText = Instance.new("TextLabel")
	local LinkValues = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local BlockLine = Instance.new("Frame")

	if Compkiller:_IsMobile() then
		Compkiller:_AddDragBlacklist(GlobalBlock);
	end;

	GlobalBlock.Name = Compkiller:_RandomString()
	GlobalBlock.BackgroundTransparency = 1.000
	GlobalBlock.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GlobalBlock.BorderSizePixel = 0
	GlobalBlock.Size = UDim2.new(1, -1, 0, 30)
	GlobalBlock.ZIndex = 10

	BlockText.Name = Compkiller:_RandomString()
	BlockText.Parent = GlobalBlock
	BlockText.AnchorPoint = Vector2.new(0, 0.5)
	BlockText.BackgroundTransparency = 1.000
	BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BlockText.BorderSizePixel = 0
	BlockText.Position = UDim2.new(0, 12, 0.5, 0)
	BlockText.Size = UDim2.new(1, -20, 0, 25)
	BlockText.ZIndex = 10
	BlockText.Font = Enum.Font.GothamMedium
	BlockText.Text = "Block"
	BlockText.TextColor3 = Compkiller.Colors.SwitchColor
	BlockText.TextSize = 14.000
	BlockText.TextTransparency = 0.300
	BlockText.TextXAlignment = Enum.TextXAlignment.Left

	table.insert(Compkiller.Elements.SwitchColor , {
		Element = BlockText,
		Property = 'TextColor3'
	});

	LinkValues.Name = Compkiller:_RandomString()
	LinkValues.Parent = GlobalBlock
	LinkValues.AnchorPoint = Vector2.new(1, 0.540000021)
	LinkValues.BackgroundTransparency = 1.000
	LinkValues.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LinkValues.BorderSizePixel = 0
	LinkValues.Position = UDim2.new(1, -12, 0.5, 0)
	LinkValues.Size = UDim2.new(1, 0, 0, 18)
	LinkValues.ZIndex = 11

	UIListLayout.Parent = LinkValues
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 8)

	BlockLine.Name = Compkiller:_RandomString()
	BlockLine.Parent = GlobalBlock
	BlockLine.AnchorPoint = Vector2.new(0.5, 1)
	BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
	BlockLine.BackgroundTransparency = 0.500
	BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BlockLine.BorderSizePixel = 0
	BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
	BlockLine.Size = UDim2.new(1, -26, 0, 1)
	BlockLine.ZIndex = 12

	table.insert(Compkiller.Elements.LineColor,{
		Element = BlockLine,
		Property = "BackgroundColor3"
	});

	local rep = {
		TextTransparency = 0.300,
		Root = GlobalBlock,
		Tween = TweenInfo.new(0.25),
	};

	function rep:SetText(Text)
		BlockText.Text = Text;
	end;

	function rep:GetText()
		return BlockText.Text;
	end;

	function rep:SetTextColor(Color)
		local oldIndex = table.find(Compkiller.Elements.SwitchColor , BlockText);

		table.remove(Compkiller.Elements.SwitchColor , oldIndex);

		BlockText.TextColor3 = Color;

		table.insert(Compkiller.Elements.Risky , {
			Element = BlockText,
			Property = 'TextColor3'
		});

	end;

	function rep:SetLine(visible)
		BlockLine.Visible = visible;

		if not visible then
			BlockLine.Parent = nil;
		else
			BlockLine.Parent = rep.Root;
		end;
	end;

	function rep:SetTransparency(num)
		rep.TextTransparency = num;

		Compkiller:_Animation(BlockText,TweenInfo.new(0.3),{
			TextTransparency = rep.TextTransparency
		});
	end;

	function rep:SetParent(parent: Frame)
		GlobalBlock.Parent = parent;

		local ZINDEX = parent.ZIndex;

		GlobalBlock.ZIndex = ZINDEX + 1;
		BlockText.ZIndex = ZINDEX + 2;
		LinkValues.ZIndex = ZINDEX + 2;
		BlockLine.ZIndex = ZINDEX + 2;
	end;

	function rep:SetVisible(bool)
		if bool then
			Compkiller:_Animation(BlockText,rep.Tween,{
				TextTransparency = rep.TextTransparency
			});

			Compkiller:_Animation(BlockLine,rep.Tween,{
				BackgroundTransparency = 0.500
			});
		else
			Compkiller:_Animation(BlockText,rep.Tween,{
				TextTransparency = 1
			});

			Compkiller:_Animation(BlockLine,rep.Tween,{
				BackgroundTransparency = 1
			});
		end;
	end;

	function rep:AddLink(Name , Default)
		return Compkiller:_AddLinkValue(Name , Default , GlobalBlock , LinkValues , rep , Signal);
	end;

	return rep;
end;

Compkiller.Hash = function(str: string)
	if typeof(str) ~= "string" then
		return "ck-unknow";
	end;

	local hex = #str;

	string.gsub(str,'.',function(byte)
		hex += byte:byte() + #str;
	end);

	local dh = string.match(str,'%d+');

	return "ck-"..tostring(math.round(hex + 15))..tostring(dh);
end;

function Compkiller:CacheImage(id: string) : string
	if not Compkiller.SecureMode or not id or not id:byte() then
		return id or "";
	end;

	assert(Compkiller.SecureMode , "please use Compkiller:Security(< string >) before cache image")
	assert(Compkiller.CacheDirectory , "please use Compkiller:Security(< string >) before cache image")

	local ids = string.match(id , "%d+");

	if ids == nil then
		return id;
	end;

	local Hash = Compkiller.Hash(id);

	local cache_path = string.format("%s/cache-%s.png" ,Compkiller.CacheDirectory , Hash);

	if isfile(cache_path) then
		return (getcustomasset or getsynasset or function() return ''; end)(cache_path);
	end;

	local imgSize = Compkiller.SecurityConfig.ImageScale;

	local imagesize = (imgSize and string.format("%sx%s", tostring(math.round(imgSize)), tostring(math.round(imgSize)))) or "150x150"

	if imagesize == nil then
		return ''
	end;

	local endpoint = string.format(
		"https://thumbnails.roblox.com/v1/assets?assetIds=%s&size=%s&format=Png&isCircular=false",
		ids,
		imagesize
	);

	local json = game:HttpGet(endpoint);

	local JSON_Decode = select(2, pcall(function()
		return HttpService:JSONDecode(json);
	end));

	if typeof(JSON_Decode) == "table" and JSON_Decode and JSON_Decode.data and JSON_Decode.data[1] and JSON_Decode.data[1].imageUrl and JSON_Decode.data[1].state == "Completed" then task.wait()
		local en = JSON_Decode.data[1].imageUrl;

		writefile(cache_path , game:HttpGet(en));

		task.wait();

		return (getcustomasset or getsynasset or function() return ''; end)(cache_path);
	end;

	return "";
end;

function Compkiller:PreloadIcons()
	local RequiredAssets = {
		"http://www.roblox.com/asset/?id=112554223509763",
		"rbxassetid://4805639000",
		"rbxassetid://6198493000",
		"rbxassetid://10709790948",
		"rbxassetid://18518299306",
		"rbxassetid://10747362393",
		"rbxassetid://18720640102",
		"rbxassetid://10723344270",
		"rbxassetid://109535175596957",
		"rbxassetid://10747384394",
		"rbxassetid://10734941499",
		Compkiller.Logo,
	};

	if Compkiller.SecureMode then
		for i,v in next , RequiredAssets do task.wait()
			pcall(function()
				Compkiller:CacheImage(v);
			end);
		end;
	else
		local ContentProvider: ContentProvider = cloneref(game:GetService('ContentProvider'));

		for i,v in next , RequiredAssets do
			ContentProvider:Preload(v);
		end;
	end;
end;

function Compkiller:Security(directory: string,Config: SecurityConfig) -- Security Mode
	directory = directory or "Compkiller-Cache";

	if not isfolder(directory) then
		makefolder(directory);
	end;

	Compkiller.SecureMode = true;

	Compkiller.SecurityConfig = Config or {};

	Compkiller.CacheDirectory = directory;
end;

function Compkiller:_AddColorPickerPanel(Button: ImageButton , Callback: (Color: Color3) -> any?)
	local Window = Compkiller:_GetWindowFromElement(Button);
	local BaseZ_Index = math.random(1,15) * 100;

	local ColorPickerWindow = Instance.new("Frame")
	local UIStroke = Instance.new("UIStroke")
	local UICorner = Instance.new("UICorner")
	local ColorPickBox = Instance.new("ImageLabel")
	local MouseMovement = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local UIStroke_2 = Instance.new("UIStroke")
	local ColorRedGreenBlue = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local UICorner_3 = Instance.new("UICorner")
	local ColorRGBSlide = Instance.new("Frame")
	local Left = Instance.new("Frame")
	local UIStroke_3 = Instance.new("UIStroke")
	local Right = Instance.new("Frame")
	local UIStroke_4 = Instance.new("UIStroke")
	local ColorOpc = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local ColorOptSlide = Instance.new("Frame")
	local Left_2 = Instance.new("Frame")
	local UIStroke_5 = Instance.new("UIStroke")
	local Right_2 = Instance.new("Frame")
	local UIStroke_6 = Instance.new("UIStroke")
	local UIGradient_2 = Instance.new("UIGradient")
	local UIStroke_7 = Instance.new("UIStroke")
	local TransparentImage = Instance.new("ImageLabel")
	local UICorner_5 = Instance.new("UICorner")
	local HexFrame = Instance.new("Frame")
	local UICorner_6 = Instance.new("UICorner")
	local UIStroke_8 = Instance.new("UIStroke")
	local TextLabel = Instance.new("TextLabel")

	ColorPickerWindow.Name = Compkiller:_RandomString()
	ColorPickerWindow.Parent = Window
	ColorPickerWindow.BackgroundColor3 = Compkiller.Colors.BlockBackground
	ColorPickerWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorPickerWindow.BorderSizePixel = 0
	ColorPickerWindow.Position = UDim2.new(123, 0, 123, 0)
	ColorPickerWindow.Size = UDim2.new(0, 175, 0, 200)
	ColorPickerWindow.ZIndex = BaseZ_Index
	ColorPickerWindow.AnchorPoint = Vector2.new(0.5,0)
	ColorPickerWindow.Active = true;

	table.insert(Compkiller.Elements.BlockBackground,{
		Element = ColorPickerWindow,
		Property = "BackgroundColor3"
	});

	Compkiller:_AddDragBlacklist(ColorPickerWindow)

	UIStroke.Color = Compkiller.Colors.HighStrokeColor
	UIStroke.Parent = ColorPickerWindow

	table.insert(Compkiller.Elements.HighStrokeColor , {
		Element = UIStroke,
		Property = "Color"
	})

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = ColorPickerWindow

	ColorPickBox.Name = Compkiller:_RandomString()
	ColorPickBox.Parent = ColorPickerWindow
	ColorPickBox.BackgroundColor3 = Color3.fromRGB(39, 255, 35)
	ColorPickBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorPickBox.BorderSizePixel = 0
	ColorPickBox.Position = UDim2.new(0, 7, 0, 7)
	ColorPickBox.Size = UDim2.new(0, 145, 0, 145)
	ColorPickBox.ZIndex = BaseZ_Index + 1
	ColorPickBox.Image = Compkiller:CacheImage("http://www.roblox.com/asset/?id=112554223509763");

	MouseMovement.Name = Compkiller:_RandomString()
	MouseMovement.Parent = ColorPickBox
	MouseMovement.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MouseMovement.BackgroundTransparency = 1.000
	MouseMovement.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MouseMovement.BorderSizePixel = 0
	MouseMovement.Position = UDim2.new(0.822222233, 0, 0.0592592582, 0)
	MouseMovement.Size = UDim2.new(0, 12, 0, 12)
	MouseMovement.ZIndex = BaseZ_Index + 5
	MouseMovement.AnchorPoint = Vector2.new(0.5,0.5)
	MouseMovement.Image = Compkiller:CacheImage("rbxassetid://4805639000")

	UICorner_2.CornerRadius = UDim.new(0, 2)
	UICorner_2.Parent = ColorPickBox

	UIStroke_2.Color = Color3.fromRGB(29, 29, 29)
	UIStroke_2.Parent = ColorPickBox

	ColorRedGreenBlue.Name = Compkiller:_RandomString()
	ColorRedGreenBlue.Parent = ColorPickerWindow
	ColorRedGreenBlue.AnchorPoint = Vector2.new(1, 0)
	ColorRedGreenBlue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorRedGreenBlue.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorRedGreenBlue.BorderSizePixel = 0
	ColorRedGreenBlue.ClipsDescendants = true
	ColorRedGreenBlue.Position = UDim2.new(1, -7, 0, 7)
	ColorRedGreenBlue.Size = UDim2.new(0, 10, 0, 145)
	ColorRedGreenBlue.ZIndex = BaseZ_Index + 6

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 153, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(203, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(50, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 102)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 101, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(50, 0, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(204, 0, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 153)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
	UIGradient.Rotation = 90
	UIGradient.Parent = ColorRedGreenBlue

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = ColorRedGreenBlue

	ColorRGBSlide.Name = Compkiller:_RandomString()
	ColorRGBSlide.Parent = ColorRedGreenBlue
	ColorRGBSlide.AnchorPoint = Vector2.new(0.5, 0)
	ColorRGBSlide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorRGBSlide.BackgroundTransparency = 1.000
	ColorRGBSlide.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorRGBSlide.BorderSizePixel = 0
	ColorRGBSlide.Position = UDim2.new(0.5, 0, 0.5, 0)
	ColorRGBSlide.Size = UDim2.new(1, 0, 0, 2)
	ColorRGBSlide.ZIndex = BaseZ_Index + 7

	Left.Name = Compkiller:_RandomString()
	Left.Parent = ColorRGBSlide
	Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Left.BorderSizePixel = 0
	Left.Size = UDim2.new(0, 2, 1, 0)
	Left.ZIndex = BaseZ_Index + 100

	UIStroke_3.Parent = Left

	Right.Name = Compkiller:_RandomString()
	Right.Parent = ColorRGBSlide
	Right.AnchorPoint = Vector2.new(1, 0)
	Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Right.BorderSizePixel = 0
	Right.Position = UDim2.new(1, 0, 0, 0)
	Right.Size = UDim2.new(0, 2, 1, 0)
	Right.ZIndex = BaseZ_Index + 100

	UIStroke_4.Parent = Right

	ColorOpc.Name = Compkiller:_RandomString()
	ColorOpc.Parent = ColorPickerWindow
	ColorOpc.BackgroundColor3 = Color3.fromRGB(102, 255, 0)
	ColorOpc.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorOpc.BorderSizePixel = 0
	ColorOpc.Position = UDim2.new(0, 7, 0, 160)
	ColorOpc.Size = UDim2.new(1, -30, 0, 9)
	ColorOpc.ZIndex = BaseZ_Index + 6

	UICorner_4.CornerRadius = UDim.new(1, 0)
	UICorner_4.Parent = ColorOpc

	ColorOptSlide.Name = Compkiller:_RandomString()
	ColorOptSlide.Parent = ColorOpc
	ColorOptSlide.AnchorPoint = Vector2.new(0, 0.5)
	ColorOptSlide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorOptSlide.BackgroundTransparency = 1.000
	ColorOptSlide.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorOptSlide.BorderSizePixel = 0
	ColorOptSlide.Position = UDim2.new(0.5, 0, 0.5, 0)
	ColorOptSlide.Size = UDim2.new(0, 2, 1, 0)
	ColorOptSlide.ZIndex = BaseZ_Index + 7

	Left_2.Name = Compkiller:_RandomString()
	Left_2.Parent = ColorOptSlide
	Left_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Left_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Left_2.BorderSizePixel = 0
	Left_2.Size = UDim2.new(1, 0, 0, 2)
	Left_2.ZIndex = BaseZ_Index + 100

	UIStroke_5.Parent = Left_2

	Right_2.Name = Compkiller:_RandomString()
	Right_2.Parent = ColorOptSlide
	Right_2.AnchorPoint = Vector2.new(0, 1)
	Right_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Right_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Right_2.BorderSizePixel = 0
	Right_2.Position = UDim2.new(0, 0, 1, 0)
	Right_2.Size = UDim2.new(1, 0, 0, 2)
	Right_2.ZIndex = BaseZ_Index + 100

	UIStroke_6.Parent = Right_2

	UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
	UIGradient_2.Parent = ColorOpc

	UIStroke_7.Transparency = 0.500
	UIStroke_7.Color = Color3.fromRGB(29, 29, 29)
	UIStroke_7.Parent = ColorOpc

	TransparentImage.Name = Compkiller:_RandomString()
	TransparentImage.Parent = ColorOpc
	TransparentImage.BackgroundTransparency = 1.000
	TransparentImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TransparentImage.BorderSizePixel = 0
	TransparentImage.Size = UDim2.new(1, 0, 1, 0)
	TransparentImage.ZIndex = BaseZ_Index + 5
	TransparentImage.Image = Compkiller:CacheImage("rbxassetid://6198493000")
	TransparentImage.ImageColor3 = Color3.fromRGB(206, 206, 206)
	TransparentImage.ScaleType = Enum.ScaleType.Crop

	UICorner_5.CornerRadius = UDim.new(1, 0)
	UICorner_5.Parent = TransparentImage

	HexFrame.Name = Compkiller:_RandomString()
	HexFrame.Parent = ColorPickerWindow
	HexFrame.AnchorPoint = Vector2.new(0.5, 1)
	HexFrame.BackgroundColor3 = Compkiller.Colors.BlockColor
	HexFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HexFrame.BorderSizePixel = 0
	HexFrame.Position = UDim2.new(0.5, 0, 1, -5)
	HexFrame.Size = UDim2.new(1, -16, 0, 20)
	HexFrame.ZIndex = BaseZ_Index + 205

	table.insert(Compkiller.Elements.BlockColor,{
		Element = HexFrame,
		Property = "BackgroundColor3"
	});

	UICorner_6.CornerRadius = UDim.new(0, 4)
	UICorner_6.Parent = HexFrame

	UIStroke_8.Color = Compkiller.Colors.HighStrokeColor
	UIStroke_8.Parent = HexFrame

	table.insert(Compkiller.Elements.HighStrokeColor,{
		Element = UIStroke_8,
		Property = "Color"
	});

	TextLabel.Parent = HexFrame
	TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	TextLabel.Size = UDim2.new(1, -10, 1, -5)
	TextLabel.ZIndex = BaseZ_Index + 206
	TextLabel.Font = Enum.Font.Gotham
	TextLabel.Text = "#FFFFFFF"
	TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
	TextLabel.TextSize = 13.000
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	table.insert(Compkiller.Elements.SwitchColor , {
		Element = TextLabel,
		Property = 'TextColor3'
	});

	local Args = {
		IsHold = false,
		IsVisible = false,
	};

	local Tween = TweenInfo.new(0.2 , Enum.EasingStyle.Quad);
	local Tween2 = TweenInfo.new(0.275 , Enum.EasingStyle.Quad);

	Compkiller:_AddPropertyEvent(ColorPickerWindow,function(v)
		ColorPickerWindow.Visible = v;

		if Compkiller.PerformanceMode then
			if ColorPickerWindow.Visible then
				Compkiller:_SetNilP(ColorPickerWindow , Window);
			else
				Compkiller:_SetNilP(ColorPickerWindow , nil);
			end;
		else
			Compkiller:_SetNilP(ColorPickerWindow , Window);
		end;
	end)

	local ToggleUI = function(bool)
		local IsSame = Args.IsVisible == bool;

		Args.IsVisible = bool;

		local CurrentScale = (Compkiller.MainUIScale and Compkiller.MainUIScale.Scale) or 1;
		local MainPosition = UDim2.new(0,(Button.AbsolutePosition.X + 95) / CurrentScale, 0, (Button.AbsolutePosition.Y + 65) / CurrentScale);
		local DropPosition = UDim2.new(0,MainPosition.X.Offset,0,MainPosition.Y.Offset + 15);

		local MUL = (Window.AbsoluteSize.Y / CurrentScale) / 2;

		if MainPosition.Y.Offset > MUL then -- go up
			MainPosition = UDim2.fromOffset(Button.AbsolutePosition.X / CurrentScale,(Button.AbsolutePosition.Y / CurrentScale) + 45);
			DropPosition = UDim2.fromOffset(MainPosition.X.Offset,MainPosition.Y.Offset - 25);

			ColorPickerWindow.AnchorPoint = Vector2.new(0.5,1)
		else
			ColorPickerWindow.AnchorPoint = Vector2.new(0.5,0)
		end;

		if bool then

			if not IsSame then
				ColorPickerWindow.Position = DropPosition
			end;

			Compkiller:_Animation(ColorPickerWindow,Tween2,{
				BackgroundTransparency = 0,
				Size = UDim2.new(0, 175, 0, 200)
			});

			Compkiller:_Animation(ColorPickerWindow,Tween,{
				Position = MainPosition,
			});

			Compkiller:_Animation(UIStroke_8,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_7,Tween,{
				Transparency = 0.5
			});

			Compkiller:_Animation(UIStroke_6,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_5,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_4,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_3,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_2,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(ColorPickBox,Tween,{
				BackgroundTransparency = 0,
				ImageTransparency = 0
			});

			Compkiller:_Animation(MouseMovement,Tween,{
				ImageTransparency = 0
			});

			Compkiller:_Animation(ColorOpc,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(TransparentImage,Tween,{
				ImageTransparency = 0
			});

			Compkiller:_Animation(Left,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(Left_2,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(Right,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(Right_2,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(ColorRedGreenBlue,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(HexFrame,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(TextLabel,Tween,{
				TextTransparency = 0
			});
		else
			Compkiller:_Animation(UIStroke_8,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_7,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_6,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_5,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_4,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_3,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_2,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(ColorPickerWindow,Tween2,{
				BackgroundTransparency = 1,
			});

			Compkiller:_Animation(ColorPickerWindow,Tween,{
				Position = DropPosition,
			});

			Compkiller:_Animation(ColorPickBox,Tween,{
				BackgroundTransparency = 1,
				ImageTransparency = 1
			});

			Compkiller:_Animation(MouseMovement,Tween,{
				ImageTransparency = 1
			});

			Compkiller:_Animation(ColorOpc,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(TransparentImage,Tween,{
				ImageTransparency = 1
			});

			Compkiller:_Animation(Left,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(Left_2,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(Right,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(Right_2,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(ColorRedGreenBlue,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(HexFrame,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(TextLabel,Tween,{
				TextTransparency = 1
			});
		end;
	end;

	Button.MouseButton1Click:Connect(function()
		ToggleUI(true);
	end)

	local H , S , V = 0,0,0;
	local Transparency = 0;

	function Args:SetColor(Color: Color3 , TransparencyValue: number)
		H , S , V = Color:ToHSV();
		Transparency = TransparencyValue;
	end;

	function Args:Update()
		local MainColor = Color3.fromHSV(H , S , 1);
		local RealColor = Color3.fromHSV(H , S , V);

		Compkiller:_Animation(ColorPickBox,TweenInfo.new(0.2),{
			BackgroundColor3 = Color3.fromHSV(H , 1 , 1)
		});

		Compkiller:_Animation(ColorOpc,TweenInfo.new(0.2),{
			BackgroundColor3 = RealColor
		});

		Compkiller:_Animation(MouseMovement,TweenInfo.new(0.2),{
			Position = UDim2.fromScale(S , 1 - V)
		});

		Compkiller:_Animation(ColorOptSlide,TweenInfo.new(0.2),{
			Position = UDim2.new(Transparency ,0 , 0.5 ,0)
		});

		Compkiller:_Animation(ColorRGBSlide,TweenInfo.new(0.2),{
			Position = UDim2.new(0.5 ,0 , H ,0)
		});

		TextLabel.Text = "#" .. tostring(RealColor:ToHex())

		Callback(RealColor , Transparency);
	end;

	local SPAWN_THREAD;

	ColorPickerWindow.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = true;

			if SPAWN_THREAD then
				task.cancel(SPAWN_THREAD);
				SPAWN_THREAD = nil;
			end;

			SPAWN_THREAD = task.spawn(function()
				while true do task.wait(0.001)
					if not Args.IsHold then
						break;	
					end;

					Callback(Color3.fromHSV(H , S , V),Transparency);
				end;
			end);
		end;
	end)

	ColorPickerWindow.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = false;

			if SPAWN_THREAD then
				task.cancel(SPAWN_THREAD);
				SPAWN_THREAD = nil;
			end;
		end;
	end)

	UserInputService.InputBegan:Connect(function(Input)
		if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and Args.IsVisible then
			if not Compkiller:_IsMouseOverFrame(ColorPickerWindow) then
				ToggleUI(false);
			end;
		end;
	end)

	ColorRedGreenBlue.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = true;

			while (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or Args.IsHold) do task.wait()
				local ColorY = ColorRedGreenBlue.AbsolutePosition.Y
				local ColorYM = ColorY + ColorRedGreenBlue.AbsoluteSize.Y;
				local Value = math.clamp(Mouse.Y, ColorY, ColorYM)
				local Code = ((Value - ColorY) / (ColorYM - ColorY));

				H = Code;

				Args:Update();
			end;
		end;
	end);

	ColorOpc.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = true;

			while (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or Args.IsHold) do task.wait()
				local transparency = math.clamp((((Mouse.X) - ColorOpc.AbsolutePosition.X) / ColorOpc.AbsoluteSize.X), 0, 1);
				local RealColor = Color3.fromHSV(H , S , V);

				TextLabel.Text = "#" .. tostring(RealColor:ToHex())

				Transparency = transparency;

				Args:Update();
			end;
		end;
	end);

	ColorPickBox.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = true;

			while (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or Args.IsHold) do task.wait();
				local PosX = ColorPickBox.AbsolutePosition.X
				local ScaleX = PosX + ColorPickBox.AbsoluteSize.X
				local Value, PosY = math.clamp(Mouse.X, PosX, ScaleX), ColorPickBox.AbsolutePosition.Y
				local ScaleY = PosY + ColorPickBox.AbsoluteSize.Y
				local Vals = math.clamp(Mouse.Y, PosY, ScaleY)
				local RealColor = Color3.fromHSV(H , S , V);

				S = (Value - PosX) / (ScaleX - PosX);
				V = (1 - ((Vals - PosY) / (ScaleY - PosY)));

				TextLabel.Text = "#" .. tostring(RealColor:ToHex())

				Args:Update();
			end
		end
	end)

	return Args;
end;

function Compkiller:_DrawKeybinds(Window: ScreenGui)
	if Compkiller.__KEYBINDS_CACHE then
		return Compkiller.__KEYBINDS_CACHE;
	end;

	local Keybinds = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local IconFrame = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local Frame = Instance.new("Frame")
	local Icon = Instance.new("ImageLabel")
	local HeaderFrame = Instance.new("Frame")
	local HeadLabel = Instance.new("TextLabel")
	local MainFrame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local MovingFrame = Instance.new("Frame")

	Keybinds.Name = Compkiller:_RandomString()
	Keybinds.Parent = Window
	Keybinds.BackgroundColor3 = Compkiller.Colors.BGDBColor;
	Keybinds.BackgroundTransparency = 0.025
	Keybinds.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Keybinds.BorderSizePixel = 0
	Keybinds.Position = UDim2.new(0,100,0,100)
	Keybinds.Size = UDim2.new(0, 125, 0, 25)
	Keybinds.ZIndex = 150

	table.insert(Compkiller.Elements.BGDBColor,{
		Element = Keybinds,
		Property = 'BackgroundColor3'
	});


	UICorner.CornerRadius = UDim.new(0, 3)
	UICorner.Parent = Keybinds

	IconFrame.Name = Compkiller:_RandomString()
	IconFrame.Parent = Keybinds
	IconFrame.AnchorPoint = Vector2.new(1, 0.5)
	IconFrame.BackgroundColor3 = Compkiller.Colors.BGDBColor
	IconFrame.BackgroundTransparency = 0.300
	IconFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	IconFrame.BorderSizePixel = 0
	IconFrame.Position = UDim2.new(0, 5, 0.5, 0)
	IconFrame.Size = UDim2.new(1, 10, 1, 0)
	IconFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
	IconFrame.ZIndex = 149

	table.insert(Compkiller.Elements.BGDBColor,{
		Element = IconFrame,
		Property = 'BackgroundColor3'
	});

	UICorner_2.CornerRadius = UDim.new(0, 3)
	UICorner_2.Parent = IconFrame

	Frame.Parent = IconFrame
	Frame.AnchorPoint = Vector2.new(0, 0.5)
	Frame.BackgroundColor3 = Compkiller.Colors.Highlight;
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(1, -5, 0.5, 0)
	Frame.Size = UDim2.new(0, 2, 1, 0)
	Frame.ZIndex = 151

	table.insert(Compkiller.Elements.Highlight,{
		Element = Frame,
		Property = 'BackgroundColor3'
	});

	Icon.Name = Compkiller:_RandomString()
	Icon.Parent = IconFrame
	Icon.AnchorPoint = Vector2.new(0.5, 0.5)
	Icon.BackgroundTransparency = 1.000
	Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Icon.BorderSizePixel = 0
	Icon.Position = UDim2.new(0.5, -2, 0.5, 0)
	Icon.Size = UDim2.new(0, 20, 0, 20)
	Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
	Icon.ZIndex = 159
	Icon.Image = Compkiller:CacheImage("rbxassetid://10723416765");

	HeaderFrame.Name = Compkiller:_RandomString()
	HeaderFrame.Parent = Keybinds
	HeaderFrame.AnchorPoint = Vector2.new(0.5, 0)
	HeaderFrame.BackgroundTransparency = 1.000
	HeaderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HeaderFrame.BorderSizePixel = 0
	HeaderFrame.ClipsDescendants = true
	HeaderFrame.Position = UDim2.new(0.5, 0, 0, 0)
	HeaderFrame.Size = UDim2.new(1, -10, 1, 0)
	HeaderFrame.ZIndex = 155

	HeadLabel.Name = Compkiller:_RandomString()
	HeadLabel.Parent = HeaderFrame
	HeadLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	HeadLabel.BackgroundTransparency = 1.000
	HeadLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HeadLabel.BorderSizePixel = 0
	HeadLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	HeadLabel.Size = UDim2.new(1, -10, 1, 0)
	HeadLabel.ZIndex = 156
	HeadLabel.Font = Enum.Font.GothamMedium
	HeadLabel.Text = "Keybinds"
	HeadLabel.TextColor3 = Compkiller.Colors.SwitchColor
	HeadLabel.TextSize = 12.000

	table.insert(Compkiller.Elements.SwitchColor,{
		Element = HeadLabel,
		Property = 'TextColor3'
	});

	MainFrame.Name = Compkiller:_RandomString()
	MainFrame.Parent = Keybinds
	MainFrame.AnchorPoint = Vector2.new(1, 0)
	MainFrame.BackgroundTransparency = 1.000
	MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BorderSizePixel = 0
	MainFrame.Position = UDim2.new(1, 0, 1, 5)
	MainFrame.Size = UDim2.new(1, 30, 1, 3)
	MainFrame.ZIndex = 156;
	MainFrame.ClipsDescendants = true;

	UIListLayout.Parent = MainFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	MovingFrame.Name = Compkiller:_RandomString()
	MovingFrame.Parent = Keybinds
	MovingFrame.AnchorPoint = Vector2.new(1, 0.5)
	MovingFrame.BackgroundTransparency = 1.000
	MovingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MovingFrame.BorderSizePixel = 0
	MovingFrame.Position = UDim2.new(1, 0, 0.5, 0)
	MovingFrame.Size = UDim2.new(1, 30, 1, 0)

	Compkiller:Drag(MovingFrame,Keybinds,0);

	local Ref = {
		Root = Keybinds
	};

	local function UpdateKeybindWindow()
		local CurrentScale = (Compkiller.MainUIScale and Compkiller.MainUIScale.Scale) or 1;
		Compkiller:_Animation(MainFrame,TweenInfo.new(0.4),{
			Size = UDim2.new(1, 30, 1, ((UIListLayout.AbsoluteContentSize.Y / CurrentScale) + 1))
		});

		if UIListLayout.AbsoluteContentSize.Y > 1 then
			Compkiller:_Animation(IconFrame,TweenInfo.new(0.25),{
				BackgroundTransparency = 0.3
			})

			Compkiller:_Animation(Frame,TweenInfo.new(0.25),{
				BackgroundTransparency = 0
			})

			Compkiller:_Animation(HeadLabel,TweenInfo.new(0.25),{
				TextTransparency = 0
			})

			Compkiller:_Animation(Icon,TweenInfo.new(0.25),{
				ImageTransparency = 0
			});

			local LargF = 100;

			for i,v in next , MainFrame:GetChildren() do
				if v:GetAttribute('AvgScale') then
					if v:GetAttribute('AvgScale') > LargF then
						LargF = v:GetAttribute('AvgScale');
					end;
				end;
			end;

			Compkiller:_Animation(Keybinds,TweenInfo.new(0.25),{
				BackgroundTransparency = 0.025,
				Size = UDim2.new(0, LargF, 0, 25)
			})
		else
			Compkiller:_Animation(HeadLabel,TweenInfo.new(0.25),{
				TextTransparency = 1
			})

			Compkiller:_Animation(Keybinds,TweenInfo.new(0.25),{
				BackgroundTransparency = 1
			})

			Compkiller:_Animation(IconFrame,TweenInfo.new(0.25),{
				BackgroundTransparency = 1
			})

			Compkiller:_Animation(Frame,TweenInfo.new(0.25),{
				BackgroundTransparency = 1
			})

			Compkiller:_Animation(Icon,TweenInfo.new(0.25),{
				ImageTransparency = 1
			});
		end;

		Keybinds.Visible = (Keybinds.BackgroundTransparency < 0.9 and true) or false;

		if Compkiller.PerformanceMode then
			if Keybinds.Visible then
				Compkiller:_SetNilP(Keybinds , Window);
			else
				Compkiller:_SetNilP(Keybinds , nil);
			end;
		else
			Compkiller:_SetNilP(Keybinds , Window);
		end;
	end

	UpdateKeybindWindow()
	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateKeybindWindow)

	function Ref:AddFrame()
		local Keyholder = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Label = Instance.new("TextLabel")
		local Line = Instance.new("Frame")
		local TypeLabel = Instance.new("TextLabel")
		local UICorner_2 = Instance.new("UICorner")

		Keyholder.Name = Compkiller:_RandomString()
		Keyholder.BackgroundColor3 = Compkiller.Colors.BGDBColor
		Keyholder.BackgroundTransparency = 1
		Keyholder.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Keyholder.BorderSizePixel = 0
		Keyholder.Size = UDim2.new(1, 0, 0, 28)
		Keyholder.ZIndex = MainFrame.ZIndex + 3
		Keyholder.ClipsDescendants = true;

		table.insert(Compkiller.Elements.BGDBColor,{
			Element = Keyholder,
			Property = 'BackgroundColor3'
		});

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = Keyholder

		Label.Name = Compkiller:_RandomString()
		Label.Parent = Keyholder
		Label.AnchorPoint = Vector2.new(0.5, 0.5)
		Label.BackgroundTransparency = 1.000
		Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Label.BorderSizePixel = 0
		Label.Position = UDim2.new(0.5, 0, 0.5, 0)
		Label.Size = UDim2.new(1, -10, 1, 0)
		Label.ZIndex = MainFrame.ZIndex + 5;
		Label.Font = Enum.Font.GothamMedium
		Label.TextColor3 = Compkiller.Colors.SwitchColor
		Label.TextSize = 11.000
		Label.TextTransparency = 1
		Label.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor,{
			Element = Label,
			Property = 'TextColor3'
		});

		Line.Name = Compkiller:_RandomString()
		Line.Parent = Keyholder
		Line.AnchorPoint = Vector2.new(1, 0.5)
		Line.BackgroundColor3 = Compkiller.Colors.BGDBColor
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(1, 0, 0.5, 0)
		Line.Size = UDim2.new(0, 30, 1, 0)
		Line.ZIndex = MainFrame.ZIndex + 4

		table.insert(Compkiller.Elements.BGDBColor,{
			Element = Line,
			Property = 'BackgroundColor3'
		});

		TypeLabel.Name = Compkiller:_RandomString()
		TypeLabel.Parent = Line
		TypeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TypeLabel.BackgroundTransparency = 1.000
		TypeLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TypeLabel.BorderSizePixel = 0
		TypeLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TypeLabel.Size = UDim2.new(1, 0, 1, 0)
		TypeLabel.ZIndex = MainFrame.ZIndex + 6
		TypeLabel.Font = Enum.Font.GothamMedium
		TypeLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TypeLabel.TextSize = 11.000

		table.insert(Compkiller.Elements.SwitchColor,{
			Element = TypeLabel,
			Property = 'TextColor3'
		});

		UICorner_2.CornerRadius = UDim.new(0, 3)
		UICorner_2.Parent = Line

		local UpdateScale = function()
			local t = TextService:GetTextSize(TypeLabel.Text , TypeLabel.TextSize , TypeLabel.Font , Vector2.new(math.huge,math.huge));
			local z = TextService:GetTextSize(Label.Text , Label.TextSize , Label.Font , Vector2.new(math.huge,math.huge));

			Line.Size = UDim2.new(0, t.X + 5, 1, 0);

			Keyholder:SetAttribute('AvgScale',(t.X + z.X) + 55);
		end;

		UpdateScale();

		local frame_ref = {};

		function frame_ref:SetName(str: string)
			Label.Text = str or Label.Text;

			UpdateScale();
		end;

		function frame_ref:SetType(str: string)
			TypeLabel.Text = str or TypeLabel.Text;

			UpdateScale();
		end;

		function frame_ref:SetVisible(v)
			if v then
				Compkiller:_Animation(Keyholder,TweenInfo.new(0.1),{
					BackgroundTransparency = 0.600,
					Size = UDim2.new(1, 0, 0, 28)
				});

				Compkiller:_Animation(Label,TweenInfo.new(0.15),{
					TextTransparency = 0.100
				});

				Compkiller:_Animation(Line,TweenInfo.new(0.15),{
					BackgroundTransparency = 0
				});

				Compkiller:_Animation(TypeLabel,TweenInfo.new(0.15),{
					TextTransparency = 0
				});
			else
				Compkiller:_Animation(Keyholder,TweenInfo.new(0.1),{
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0)
				});

				Compkiller:_Animation(Label,TweenInfo.new(0.15),{
					TextTransparency = 1
				});

				Compkiller:_Animation(Line,TweenInfo.new(0.15),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(TypeLabel,TweenInfo.new(0.15),{
					TextTransparency = 1
				});
			end;

			if Keyholder.BackgroundTransparency <= 0.95 then
				Keyholder.Parent = MainFrame;
			else
				Keyholder.Parent = nil;
			end;

			UpdateScale();
		end;

		return frame_ref;
	end;

	Compkiller.__KEYBINDS_CACHE = Ref;

	return Ref;
end;

function Compkiller:_KeybindHandler(Parent: Frame , ObjectType: string , ElementAPI: Toggle & Slider , Signal , Zindex: number , ElementCFG: Slider)
	local Window = Compkiller:_GetWindowFromElement(Parent);
	local KB_Signal = Compkiller.__SIGNAL(false);
	local SubIndex = math.random(40,100);
	local KeybindInd = Compkiller:_DrawKeybinds(Window);
	local KeybindFrame = KeybindInd:AddFrame();

	local KeybindHandler = Instance.new("Frame")
	local UIStroke = Instance.new("UIStroke")
	local UICorner = Instance.new("UICorner")
	local ElementObjs = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	KeybindHandler.Name = Compkiller:_RandomString()
	KeybindHandler.Parent = Window
	KeybindHandler.BackgroundColor3 = Compkiller.Colors.BlockBackground
	KeybindHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
	KeybindHandler.BorderSizePixel = 0
	KeybindHandler.ClipsDescendants = true
	KeybindHandler.Position = UDim2.new(1,999,1,999)
	KeybindHandler.Size = UDim2.new(0, 225, 0, 0)
	KeybindHandler.ZIndex = Zindex + SubIndex
	KeybindHandler.AnchorPoint = Vector2.new(0.5,0)

	table.insert(Compkiller.Elements.BlockBackground,{
		Element = KeybindHandler,
		Property = 'BackgroundColor3'
	});

	UIStroke.Color = Compkiller.Colors.HighStrokeColor
	UIStroke.Parent = KeybindHandler

	table.insert(Compkiller.Elements.HighStrokeColor,{
		Element = UIStroke,
		Property = 'Color'
	});

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = KeybindHandler

	ElementObjs.Name = Compkiller:_RandomString()
	ElementObjs.Parent = KeybindHandler
	ElementObjs.AnchorPoint = Vector2.new(0.5, 0.5)
	ElementObjs.BackgroundTransparency = 1.000
	ElementObjs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ElementObjs.BorderSizePixel = 0
	ElementObjs.Position = UDim2.new(0.5, 0, 0.5, 0)
	ElementObjs.Size = UDim2.new(1, -5, 1, -5)
	ElementObjs.ZIndex = Zindex + SubIndex + 10

	UIListLayout.Parent = ElementObjs
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local refreshPF = function()
		if Compkiller.PerformanceMode then
			if KeybindHandler.Size.Y.Offset > 1 then
				Compkiller:_SetNilP(KeybindHandler , Window);
			else
				Compkiller:_SetNilP(KeybindHandler , nil);
			end;
		else
			Compkiller:_SetNilP(KeybindHandler , Window);
		end;
	end;

	KeybindHandler:GetPropertyChangedSignal('Size'):Connect(refreshPF);

	task.delay(0.1,refreshPF);

	local ToggleUI = function(bool)
		if bool then
			KeybindHandler.Position = UDim2.new(0,Parent.AbsolutePosition.X + 225,0,Parent.AbsolutePosition.Y)

			Compkiller:_Animation(KeybindHandler,TweenInfo.new(0.25),{
				BackgroundTransparency = 0,
				Size = UDim2.new(0, 225, 0, UIListLayout.AbsoluteContentSize.Y + 5)
			});

			Compkiller:_Animation(UIStroke,TweenInfo.new(0.3),{
				Transparency = 0
			});
		else
			Compkiller:_Animation(KeybindHandler,TweenInfo.new(0.3),{
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 225, 0, 0)
			});

			Compkiller:_Animation(UIStroke,TweenInfo.new(0.3),{
				Transparency = 1
			});
		end;
	end;

	ToggleUI(false);

	KB_Signal:Connect(ToggleUI);

	local APIRef = {
		Name = ElementAPI:GetText()
	};

	local ModeEnum = {
		[1] = 'Off', -- disabled / off
		[2] = "Hold",
		[3] = "Toggle",
		[4] = "On", -- alway on
	};

	local e_m = {
		['Off'] = 1,
		['Hold'] = 2,
		['Toggle'] = 3,
		['On'] = 4,
	};

	if ObjectType == "Toggle" then
		APIRef.Off = false;
		APIRef.On = true;
		APIRef.Keybind = nil;
		APIRef.Mode = e_m.Off;


	elseif ObjectType == "Number" then
		APIRef.Off = 1;
		APIRef.On = 0;
		APIRef.Keybind = nil;
		APIRef.Mode = e_m.Off;
	end;

	local Flag = {};

	APIRef.Update = function()
		KeybindFrame:SetName(APIRef.Name);
		KeybindFrame:SetType(ModeEnum[APIRef.Mode]);
	end

	local ElementAPIs = Compkiller:_LoadElement(ElementObjs , true , KB_Signal , true);

	Flag.Key = ElementAPIs:AddKeybind({
		Name = "Key",
		Default = APIRef.Keybind,
		Callback = function(v)
			APIRef.Keybind = v;
		end,
	});

	Flag.Mode = ElementAPIs:AddDropdown({
		Name = "Mode",
		Default = ModeEnum[APIRef.Mode],
		Values = ModeEnum,
		Callback = function(v)
			APIRef.Mode = e_m[v];

			if APIRef.Mode == 4 then
				ElementAPI:SetValue(APIRef.On);
			end;
		end,
	});

	if ObjectType == "Toggle" then
		Flag.On = ElementAPIs:AddToggle({
			Name = "ON Value",
			Default = APIRef.On,
			Callback = function(v)
				APIRef.On = v;
			end,
		});

		Flag.Off = ElementAPIs:AddToggle({
			Name = "OFF Value",
			Default = APIRef.Off,
			Callback = function(v)
				APIRef.Off = v;
			end,
		});
	elseif ObjectType == "Number" then
		Flag.On = ElementAPIs:AddSlider({
			Name = "ON Value",
			Default = APIRef.On,
			Min = ElementCFG.Min,
			Round = ElementCFG.Round,
			Max = ElementCFG.Max,
			Type = ElementCFG.Type,
			Callback = function(v)
				APIRef.On = v;
			end,
		});

		Flag.Off = ElementAPIs:AddSlider({
			Name = "OFF Value",
			Default = APIRef.Off,
			Min = ElementCFG.Min,
			Round = ElementCFG.Round,
			Max = ElementCFG.Max,
			Type = ElementCFG.Type,
			Callback = function(v)
				APIRef.Off = v;
			end,
		});
	end;

	Flag.ShowInKeybindList = ElementAPIs:AddTextBox({
		Name = "Name",
		Default = APIRef.Name,
		Placeholder = "Keybind Name",
		Callback = function(v)
			APIRef.Name = v;
		end,
	})

	function APIRef:GetSettings()
		APIRef.Update();

		return {
			Key = APIRef.Keybind,
			On = APIRef.On,
			Off = APIRef.Off,
			Mode = APIRef.Mode,
			Name = APIRef.Name,
		};
	end;

	function APIRef:LoadSettings(cfg : KeybindSettings)
		Flag.ShowInKeybindList:SetValue(cfg.Name);
		Flag.Off:SetValue(cfg.Off);
		Flag.On:SetValue(cfg.On);
		Flag.Mode:SetValue(ModeEnum[cfg.Mode]);
		Flag.Key:SetValue(cfg.Key);

		APIRef.Update();
	end;

	APIRef.Thread = task.spawn(function()
		while true do task.wait(0.5)
			if APIRef.Mode ~= 1 then
				if ElementAPI:GetValue() == APIRef.On then
					KeybindFrame:SetVisible(true);
				else
					KeybindFrame:SetVisible(false);
				end;

				APIRef.Update();
			else
				KeybindFrame:SetVisible(false);
			end;
		end;
	end)

	Parent.InputEnded:Connect(function(Input,Typing)
		if Input.UserInputType == Enum.UserInputType.MouseButton2 and not Typing then
			KB_Signal:Fire(true);
		end;
	end);

	UserInputService.InputBegan:Connect(function(Input)
		if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseButton2 or Input.UserInputType == Enum.UserInputType.Touch) and KB_Signal:GetValue() then
			if not Compkiller:_IsMouseOverFrame(Parent) and not Compkiller:_IsMouseOverFrame(KeybindHandler) then
				KB_Signal:Fire(false);
			end;
		end;
	end);

	UserInputService.InputBegan:Connect(function(Input,Typing)
		if APIRef.Keybind and (Input.KeyCode.Name == APIRef.Keybind or Input.KeyCode == APIRef.Keybind or (Input.UserInputType == Enum.UserInputType.MouseButton1 and APIRef.Keybind == "MouseLeft") or (Input.UserInputType == Enum.UserInputType.MouseButton2 and APIRef.Keybind == "MouseRight")) then

			if APIRef.Mode == 2 or APIRef.Mode == 4 then
				ElementAPI:SetValue(APIRef.On);
			elseif APIRef.Mode == 3 then
				if ElementAPI:GetValue() == APIRef.On then
					ElementAPI:SetValue(APIRef.Off);
				else
					ElementAPI:SetValue(APIRef.On);
				end;
			end;
		end;
	end);

	UserInputService.InputEnded:Connect(function(Input,Typing)
		if APIRef.Keybind and (Input.KeyCode.Name == APIRef.Keybind or Input.KeyCode == APIRef.Keybind or (Input.UserInputType == Enum.UserInputType.MouseButton1 and APIRef.Keybind == "MouseLeft") or (Input.UserInputType == Enum.UserInputType.MouseButton2 and APIRef.Keybind == "MouseRight")) then

			if APIRef.Mode == 2 then
				ElementAPI:SetValue(APIRef.Off);
			elseif APIRef.Mode == 4 then
				ElementAPI:SetValue(APIRef.On);
			end;
		end;
	end);

	return APIRef;
end;

function Compkiller:_AddPropertyEvent(Target: Frame , Callback: (boolean) -> any)
	Target:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
		Callback(Target.BackgroundTransparency <= 0.9)
	end)
end;

function Compkiller:_LoadOption(Value , TabSignal)
	local Args = {};
	local Window = Compkiller:_GetWindowFromElement(Value.Root);
	local Tween = TweenInfo.new(0.3,Enum.EasingStyle.Quint);

	function Args:AddKeybind(Config: MiniKeybind)
		Config = Compkiller.__CONFIG(Config,{
			Name = "Keybind",
			Default = nil,
			Flag = nil,
			Callback = function() end;
			Blacklist = {}
		});

		local Keybind = Value:AddLink('Keybind' , Config.Default);

		local IsBinding = false;

		local IsBlacklist = function(v)
			return Config.Blacklist and (Config.Blacklist[v] or table.find(Config.Blacklist,v))
		end;

		Compkiller:_Input(Keybind.Root,function()
			if IsBinding then
				return;
			end;

			Keybind.SetValue("...");

			local Selected = nil;

			while not Selected do
				local Key = UserInputService.InputBegan:Wait();

				if Key.KeyCode ~= Enum.KeyCode.Unknown and not IsBlacklist(Key.KeyCode) and not IsBlacklist(Key.KeyCode.Name) then
					Selected = Key.KeyCode;
				else
					if Key.UserInputType == Enum.UserInputType.MouseButton1 and not IsBlacklist(Enum.UserInputType.MouseButton1) and not IsBlacklist("MouseLeft") then
						Selected = "MouseLeft";
					elseif Key.UserInputType == Enum.UserInputType.MouseButton2 and not IsBlacklist(Enum.UserInputType.MouseButton2) and not IsBlacklist("MouseRight") then
						Selected = "MouseRight";
					end;
				end;
			end;

			local KeyName = (typeof(Selected) == "string" and Selected) or Selected.Name;

			Config.Default = KeyName;

			Keybind.SetValue(Selected);

			IsBinding = false;

			Config.Callback(KeyName);
		end);

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(value)
			Config.Default = value;

			Keybind.SetValue(Config.Default);

			Config.Callback(Config.Default);
		end;

		function Args:GetValue()
			return (typeof(Config.Default) == "string" and Config.Default) or Config.Default.Name;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddHelper(Config: Helper)
		Config = Compkiller.__CONFIG(Config,{
			Text = "Information."
		});

		local Helper = Value:AddLink("Helper" , Config.Default);
		local Button: ImageButton = Helper.InfoButton;

		Helper.Text.Parent = Window;

		Helper.UIStroke:GetPropertyChangedSignal('Transparency'):Connect(function()
			if Helper.UIStroke.Transparency > 0.9 then
				Helper.Text.Visible = false;
			else
				Helper.Text.Visible = true;
			end;

			if Compkiller.PerformanceMode then
				if Helper.Text.Visible then
					Compkiller:_SetNilP(Helper.Text , Window);
				else
					Compkiller:_SetNilP(Helper.Text , nil);
				end;
			else
				Compkiller:_SetNilP(Helper.Text , Window);
			end;
		end)

		local Update = function()
			local mainText = " "..Config.Text;

			mainText = string.gsub(mainText,'\n','\n ')

			Helper.Text.Text = mainText;

			local scale = TextService:GetTextSize(Helper.Text.Text,Helper.Text.TextSize,Helper.Text.Font,Vector2.new(math.huge,math.huge));

			local CurrentScale = WindowArgs.MainUIScale.Scale;
			Compkiller:_Animation(Helper.Text , TweenInfo.new(0.15), {
				Size = UDim2.fromOffset((scale.X + 50) / CurrentScale, (scale.Y + 5) / CurrentScale)
			})

			return scale;
		end;

		local Release = function()
			local scale = Update()

			local CurrentScale = WindowArgs.MainUIScale.Scale;
			Compkiller:_Animation(Helper.Text,TweenInfo.new(0.15),{
				TextTransparency = 1,
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(Button.AbsolutePosition.X / CurrentScale,(Button.AbsolutePosition.Y / CurrentScale) + (45))
			});

			Compkiller:_Animation(Helper.UIStroke,TweenInfo.new(0.15),{
				Transparency = 1
			});
		end;

		local Hold = function()
			local scale = Update()
			local CurrentScale = WindowArgs.MainUIScale.Scale;

			if not Helper.Text.Visible then
				Helper.Text.Position = UDim2.fromOffset(Button.AbsolutePosition.X / CurrentScale,(Button.AbsolutePosition.Y / CurrentScale) + (45))
			end;

			Compkiller:_Animation(Helper.Text,TweenInfo.new(0.15),{
				TextTransparency = 0.35,
				BackgroundTransparency = 0,
				Position = UDim2.fromOffset(Button.AbsolutePosition.X / CurrentScale,(Button.AbsolutePosition.Y / CurrentScale) + (40 - (scale.Y / 2)))
			});

			Compkiller:_Animation(Helper.UIStroke,TweenInfo.new(0.15),{
				Transparency = 0
			});

		end;

		Compkiller:_Hover(Button,  Hold, Release);

		Release();

		local Args = {};

		function Args:SetValue(value)
			Config.Text = value;
		end;

		return Args;
	end;

	function Args:AddColorPicker(Config: MiniColorPicker)
		Config = Compkiller.__CONFIG(Config,{
			Default = Color3.fromRGB(255,255,255),
			Transparency = 0,
			Callback = function() end
		});

		local ColorPicker:Frame , ColorFrame: Frame = Value:AddLink('ColorPicker' , Config.Default);

		local Button = Compkiller:_Input(ColorPicker);

		local ColorPicker = Compkiller:_AddColorPickerPanel(Button,function(color,opc)
			Config.Default = color;
			Config.Transparency = opc;

			ColorFrame.BackgroundColor3 = color;
			ColorFrame.BackgroundTransparency = opc;

			Config.Callback(Config.Default , Config.Transparency);
		end);

		ColorPicker:SetColor(Config.Default,Config.Transparency);
		ColorPicker:Update()

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(value,opc)
			Config.Default = value;
			Config.Transparency = opc;

			ColorPicker:SetColor(value,opc)

			ColorPicker:Update()

			Config.Callback(value,opc);
		end;

		function Args:GetValue()
			return {
				ColorPicker = {
					Color = Config.Default,
					Transparency = Config.Transparency
				}
			};
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddToggle(Config : MiniToggle)
		Config = Compkiller.__CONFIG(Config,{
			Flag = nil,
			Default = false,
			Callback = function() end;
		});

		local Toggle = Value:AddLink("Toggle" , Config.Default);

		Toggle.Input.MouseButton1Click:Connect(function()
			Config.Default = not Config.Default;

			Toggle.ChangeValue(Config.Default);

			Config.Callback(Config.Default);
		end);

		local Args = {};

		Args.Flag = Config.Flag

		function Args:SetValue(value)
			Config.Default = value;

			Toggle.ChangeValue(Config.Default);

			Config.Callback(Config.Default);
		end;

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddOption()
		local Element: ImageButton = Value:AddLink("Option");
		local BaseZ_Index = math.random(1,15) * 100;

		local Signal = Compkiller.__SIGNAL(false);

		local ExtractElement = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local Elements = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local Toggl = false;

		local ToggleUI = function(bool)
			local IsSameValue = bool == Toggl;

			local CurrentScale = WindowArgs.MainUIScale.Scale;
			local MainPosition = UDim2.fromOffset(Element.AbsolutePosition.X / CurrentScale, (Element.AbsolutePosition.Y / CurrentScale) + 80);
			local DropPosition = UDim2.fromOffset(MainPosition.X.Offset,MainPosition.Y.Offset + 15);
			local MUL = (Window.AbsoluteSize.Y / CurrentScale) / 2;

			if (MainPosition.Y.Offset + (40 / CurrentScale)) > MUL then -- go up
				MainPosition = UDim2.fromOffset(Element.AbsolutePosition.X / CurrentScale, (Element.AbsolutePosition.Y / CurrentScale) + 45);
				DropPosition = UDim2.fromOffset(MainPosition.X.Offset,MainPosition.Y.Offset - 25);
				ExtractElement.AnchorPoint = Vector2.new(0,1)
			else
				ExtractElement.AnchorPoint = Vector2.new(0,0)
			end;

			if bool then
				Signal:Fire(true);

				if not IsSameValue then
					ExtractElement.Position = DropPosition
				end;

				Compkiller:_Animation(ExtractElement , Tween , {
					Position = MainPosition,
					BackgroundTransparency = 0,
					Size = UDim2.new(0, 225, 0, UIListLayout.AbsoluteContentSize.Y)
				});

				Compkiller:_Animation(UIStroke , Tween , {
					Transparency = 0
				});

			else
				Signal:Fire(false);

				Compkiller:_Animation(ExtractElement , Tween , {
					Position = DropPosition,
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 225, 0, UIListLayout.AbsoluteContentSize.Y - 10)
				});

				Compkiller:_Animation(UIStroke , Tween , {
					Transparency = 1
				});
			end;
		end;

		Compkiller:_AddPropertyEvent(ExtractElement,function(bool)
			ExtractElement.Visible = bool;

			if Compkiller.PerformanceMode then
				if ExtractElement.Visible then
					Compkiller:_SetNilP(ExtractElement , Window);
				else
					Compkiller:_SetNilP(ExtractElement , nil);
				end;
			else
				Compkiller:_SetNilP(ExtractElement , Window);
			end;
		end);

		Compkiller:_AddDragBlacklist(ExtractElement);

		ExtractElement.Name = Compkiller:_RandomString()
		ExtractElement.Parent = Window
		ExtractElement.BackgroundColor3 = Compkiller.Colors.BlockBackground
		ExtractElement.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ExtractElement.BorderSizePixel = 0
		ExtractElement.ClipsDescendants = true
		ExtractElement.Position = UDim2.new(123, 0, 123, 0)
		ExtractElement.Size = UDim2.new(0, 225, 0, 35)
		ExtractElement.ZIndex = BaseZ_Index
		ExtractElement.Visible = false
		ExtractElement.ClipsDescendants = true

		table.insert(Compkiller.Elements.BlockBackground,{
			Element = ExtractElement,
			Property = "BackgroundColor3"
		});

		UIStroke.Color = Compkiller.Colors.HighStrokeColor
		UIStroke.Parent = ExtractElement

		table.insert(Compkiller.Elements.HighStrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = ExtractElement

		Elements.Name = Compkiller:_RandomString()
		Elements.Parent = ExtractElement
		Elements.AnchorPoint = Vector2.new(0.5, 0.5)
		Elements.BackgroundTransparency = 1.000
		Elements.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Elements.BorderSizePixel = 0
		Elements.Position = UDim2.new(0.5, 0, 0.5, 0)
		Elements.Size = UDim2.new(1, -5, 1,-1)
		Elements.ZIndex = BaseZ_Index + 20

		UIListLayout.Parent = Elements
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 0)

		ToggleUI(false);

		Element.MouseButton1Click:Connect(function()
			ToggleUI(true);
		end);

		UserInputService.InputBegan:Connect(function(Input)
			if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and Toggl then
				if not Compkiller:_IsMouseOverFrame(ExtractElement) and not Compkiller:_IsMouseOverFrame(Element) then
					ToggleUI(false);
				end;
			end
		end)		

		return Compkiller:_LoadElement(Elements , true , Signal)
	end;

	return Args;
end;

function Compkiller:_LoadDropdown(BaseParent: TextButton , Callback: () -> any)
	local Window = Compkiller:_GetWindowFromElement(BaseParent);

	local BaseZ_Index = BaseParent.ZIndex + (math.random(1,15) * 100);

	local DropdownWindow = Instance.new("Frame")
	local UIStroke = Instance.new("UIStroke")
	local UICorner = Instance.new("UICorner")
	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local ToggleDb = Compkiller.__SIGNAL(false);
	local EventOut = Compkiller.__SIGNAL(0);

	DropdownWindow.Name = Compkiller:_RandomString()
	DropdownWindow.Parent = Window
	DropdownWindow.BackgroundColor3 = Compkiller.Colors.BlockBackground
	DropdownWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DropdownWindow.BorderSizePixel = 0
	DropdownWindow.Position = UDim2.new(123, 0, 123, 0)
	DropdownWindow.Size = UDim2.new(0, 190, 0, 200)
	DropdownWindow.ZIndex = BaseZ_Index

	table.insert(Compkiller.Elements.BlockBackground,{
		Element = DropdownWindow,
		Property = "BackgroundColor3"
	});

	Compkiller:_AddDragBlacklist(DropdownWindow);
	Compkiller:_AddPropertyEvent(DropdownWindow,function(v)
		DropdownWindow.Visible = v;

		if Compkiller.PerformanceMode then
			if DropdownWindow.Visible then
				Compkiller:_SetNilP(DropdownWindow , Window);
			else
				Compkiller:_SetNilP(DropdownWindow , nil);
			end;
		else
			Compkiller:_SetNilP(DropdownWindow , Window);
		end;
	end)

	UIStroke.Color = Compkiller.Colors.HighStrokeColor
	UIStroke.Parent = DropdownWindow

	table.insert(Compkiller.Elements.HighStrokeColor , {
		Element = UIStroke,
		Property = "Color"
	})

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = DropdownWindow

	ScrollingFrame.Parent = DropdownWindow
	ScrollingFrame.Active = true
	ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	ScrollingFrame.BackgroundTransparency = 1.000
	ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	ScrollingFrame.Size = UDim2.new(1, -5, 1, -5)
	ScrollingFrame.ZIndex = BaseZ_Index + 5
	ScrollingFrame.BottomImage = ""
	ScrollingFrame.ScrollBarThickness = 0
	ScrollingFrame.TopImage = ""

	UIListLayout.Parent = ScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 10)

	UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		local CurrentScale = (Compkiller.MainUIScale and Compkiller.MainUIScale.Scale) or 1;
		ScrollingFrame.CanvasSize = UDim2.fromOffset(UIListLayout.AbsoluteContentSize.X / CurrentScale,UIListLayout.AbsoluteContentSize.Y / CurrentScale)
	end);

	local ToggleUI = function(bool)
		local IsSame = ToggleDb:GetValue() == bool;

		EventOut:Fire(bool);
		ToggleDb:Fire(bool);

		local CurrentScale = (Compkiller.MainUIScale and Compkiller.MainUIScale.Scale) or 1;
		local MUL = (Window.AbsoluteSize.Y / CurrentScale) / 2;

		local MainPosition = UDim2.fromOffset((BaseParent.AbsolutePosition.X / CurrentScale) + 1, (BaseParent.AbsolutePosition.Y / CurrentScale) + 80);
		local DropPosition = UDim2.fromOffset(MainPosition.X.Offset, MainPosition.Y.Offset + 25);

		if MainPosition.Y.Offset > MUL then -- go up
			MainPosition = UDim2.fromOffset((BaseParent.AbsolutePosition.X / CurrentScale) + 1, (BaseParent.AbsolutePosition.Y / CurrentScale) + 55);
			DropPosition = UDim2.fromOffset(MainPosition.X.Offset, MainPosition.Y.Offset - 25);

			DropdownWindow.AnchorPoint = Vector2.new(0,1);
		else
			DropdownWindow.AnchorPoint = Vector2.zero;
		end;

		if bool then
			if not IsSame then
				DropdownWindow.Position = DropPosition;
			end;

			 Compkiller:_Animation(DropdownWindow,TweenInfo.new(0.2),{
				BackgroundTransparency = 0,
				Position = MainPosition,
				Size = UDim2.new(0, (BaseParent.AbsoluteSize.X / CurrentScale) - 1, 0, math.clamp((UIListLayout.AbsoluteContentSize.Y / CurrentScale) + 10, 10, 200))
			})

			Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
				Transparency = 0
			})
		else
			Compkiller:_Animation(DropdownWindow,TweenInfo.new(0.2),{
				BackgroundTransparency = 1,
				Position = DropPosition,
				Size = UDim2.new(0, (BaseParent.AbsoluteSize.X / CurrentScale) - 1, 0, math.clamp((UIListLayout.AbsoluteContentSize.Y / CurrentScale) / 1.5, 10, 200))
			})

			Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
				Transparency = 1
			})
		end;
	end;

	ToggleUI(false)

	local SpamUpdate,_Delay = false , tick();
	local __signals = {};
	local Default = nil;
	local Values = nil;
	local IsMulti = false;

	local DrawButton = function()
		local DropdownItem = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local BlockLine = Instance.new("Frame")

		DropdownItem.Name = Compkiller:_RandomString()
		DropdownItem.BackgroundTransparency = 1.000
		DropdownItem.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DropdownItem.BorderSizePixel = 0
		DropdownItem.Size = UDim2.new(1, -1, 0, 20)
		DropdownItem.ZIndex = BaseZ_Index + 6

		BlockText.Name = Compkiller:_RandomString()
		BlockText.Parent = DropdownItem
		BlockText.AnchorPoint = Vector2.new(0, 0.5)
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 5, 0.5, 0)
		BlockText.Size = UDim2.new(1, -10, 0, 25)
		BlockText.ZIndex = BaseZ_Index + 6
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = ""
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 13.000
		BlockText.TextTransparency = 0.500
		BlockText.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = BlockText,
			Property = 'TextColor3'
		});

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = DropdownItem
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -6, 0, 1)
		BlockLine.ZIndex = BaseZ_Index + 7

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		return {
			BlockText = BlockText,
			DropdownItem = DropdownItem,
			BlockLine = BlockLine,
		};
	end;

	local ClearDropdown = function()
		for i,v in next , ScrollingFrame:GetChildren() do
			if v:IsA('Frame') then
				v:Destroy();
			end;
		end;

		for i,v in next,  __signals do
			v:Disconnect();
		end;
	end;

	local IsDefault = function(v)
		return (typeof(Default) == 'table' and (Default[v] or table.find(Default,v))) or Default == v;
	end;

	local MatchDefault = function(v,DataFrame)
		return (typeof(DataFrame) == 'table' and (DataFrame[v] or table.find(DataFrame,v))) or DataFrame == v;
	end;

	local UpdateDropdown = function()
		local DataFrame;

		if IsMulti then
			DataFrame = {};
		end;

		for i,v in next , Values do
			local bth = DrawButton();

			bth.BlockText.Text = tostring(v);

			bth.DropdownItem.Parent = ScrollingFrame;

			bth.Value = v;

			table.insert(__signals , ToggleDb:Connect(function(bool)
				if bool then
					Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
						TextTransparency = ((IsDefault(v) or MatchDefault(v,DataFrame)) and 0) or 0.5
					});

					Compkiller:_Animation(bth.BlockLine,TweenInfo.new(0.2),{
						BackgroundTransparency = 0
					});
				else
					Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
						TextTransparency = 1
					});

					Compkiller:_Animation(bth.BlockLine,TweenInfo.new(0.2),{
						BackgroundTransparency = 1
					});
				end;
			end));

			if ToggleDb:GetValue() then
				Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
					TextTransparency = ((IsDefault(v) or MatchDefault(v,DataFrame)) and 0) or 0.5
				});
			end;

			if IsDefault(v) and not IsMulti then
				DataFrame = bth;
			end;

			if IsMulti then
				if IsDefault(v) or MatchDefault(v,DataFrame) then
					DataFrame[v] = true;
				else
					DataFrame[v] = false;
				end;

				Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
					TextTransparency = ((MatchDefault(v,DataFrame)) and 0) or 0.5
				});

				Compkiller:_Input(bth.DropdownItem,function()
					DataFrame[v] = not DataFrame[v];

					Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
						TextTransparency = ((MatchDefault(v,DataFrame)) and 0) or 0.5
					});

					Callback(DataFrame)
				end);
			else
				Compkiller:_Input(bth.DropdownItem,function()
					if DataFrame then
						Compkiller:_Animation(DataFrame.BlockText,TweenInfo.new(0.2),{
							TextTransparency = ((IsDefault(v) or MatchDefault(v,DataFrame)) and 0) or 0.5
						});
					end;

					Default = v;

					DataFrame = bth;

					Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
						TextTransparency = ((IsDefault(v) or MatchDefault(v,DataFrame)) and 0) or 0.5
					});

					Callback(DataFrame.Value)
				end);
			end;
		end;
	end;

	BaseParent.MouseButton1Click:Connect(function()
		if SpamUpdate then
			ClearDropdown();
			UpdateDropdown();
		end;

		ToggleUI(true);

		if not ToggleDb:GetValue() then
			ToggleUI(false);
		end
	end);

	UserInputService.InputBegan:Connect(function(Input)
		if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and ToggleDb:GetValue() then
			if not Compkiller:_IsMouseOverFrame(DropdownWindow) then
				ToggleUI(false);
			end;
		end;
	end);

	local Args = {};

	function Args:SetDefault(v)
		Default = v;
	end;

	function Args:SetData(Def,Val,Multi,Vis)
		if Vis and ((tick() - _Delay) <= 0.5 or #Val > 10) then
			_Delay = tick();
			SpamUpdate = true;
		else
			SpamUpdate = false;	
		end;

		IsMulti = Multi;
		Default = Def;
		Values = Val;

		if Vis and not SpamUpdate then
			ClearDropdown();
			UpdateDropdown();
		end;
	end;

	function Args:Refersh()
		ClearDropdown();
		UpdateDropdown();
	end;

	Args.EventOut = EventOut;

	return Args;
end;

function Compkiller:_LoadElement(Parent: Frame , EnabledLine: boolean , Signal , DisableStackKeybind)
	local Zindex = Parent.ZIndex + 1;
	local Tween = TweenInfo.new(0.25,Enum.EasingStyle.Quint);

	local Args = {};

	function Args:AddToggle(Config : Toggle)
		Config = Compkiller.__CONFIG(Config,{
			Name = "Toggle",
			Default = false,
			Flag = nil,
			Risky = false,
			Callback = function() end;
		});

		local Block = Compkiller:_CreateBlock(Signal);

		Block:SetParent(Parent);

		Block:SetText(Config.Name);

		if Config.Risky then
			Block:SetTextColor(Compkiller.Colors.Risky);
		end;

		Block:SetLine(EnabledLine);

		Block:SetVisible(Signal:GetValue());

		local Toggle = Block:AddLink('Toggle' , Config.Default);

		Toggle.Input.MouseButton1Click:Connect(function()
			Config.Default = not Config.Default;

			Toggle.ChangeValue(Config.Default);

			Block:SetTransparency((Config.Default and 0.1) or 0.3);

			Config.Callback(Config.Default);
		end);

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(value)
			Config.Default = value;

			Toggle.ChangeValue(Config.Default);

			Block:SetTransparency((Config.Default and 0.1) or 0.3);

			Config.Callback(Config.Default);
		end;

		Args.Signal = Signal:Connect(function(bool)
			Block:SetVisible(bool);

		end);

		Args.Link = Compkiller:_LoadOption(Block);

		function Args:GetValue()
			return Config.Default;
		end;

		function Args:SetText(str : string)
			Block:SetText(str or Config.Name);
		end;

		function Args:GetText()
			return Block:GetText();
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		if not DisableStackKeybind then
			local AutoKeybind = Compkiller:_KeybindHandler(Block.Root , "Toggle" , Args , Signal , Zindex , Config);

			Args.AutoKeybind = AutoKeybind;
		end;

		return Args;
	end;

	function Args:AddKeybind(Config : Keybind)
		Config = Compkiller.__CONFIG(Config,{
			Name = "Keybind",
			Default = nil,
			Flag = nil,
			Callback = function() end;
			Blacklist = {}
		});

		local Block = Compkiller:_CreateBlock(Signal);

		Block:SetParent(Parent);

		Block:SetText(Config.Name);

		Block:SetLine(EnabledLine);

		Block:SetVisible(Signal:GetValue());

		local Keybind = Block:AddLink('Keybind' , Config.Default);

		local IsBinding = false;

		local IsBlacklist = function(v)
			return Config.Blacklist and (Config.Blacklist[v] or table.find(Config.Blacklist,v))
		end;

		Compkiller:_Input(Keybind.Root,function()
			if IsBinding then
				return;
			end;

			Keybind.SetValue("...");

			local Selected = nil;

			while not Selected do
				local Key = UserInputService.InputBegan:Wait();

				if Key.KeyCode ~= Enum.KeyCode.Unknown and not IsBlacklist(Key.KeyCode) and not IsBlacklist(Key.KeyCode.Name) then
					Selected = Key.KeyCode;
				else
					if Key.UserInputType == Enum.UserInputType.MouseButton1 and not IsBlacklist(Enum.UserInputType.MouseButton1) and not IsBlacklist("MouseLeft") then
						Selected = "MouseLeft";
					elseif Key.UserInputType == Enum.UserInputType.MouseButton2 and not IsBlacklist(Enum.UserInputType.MouseButton2) and not IsBlacklist("MouseRight") then
						Selected = "MouseRight";
					end;
				end;
			end;

			local KeyName = typeof(Selected) == "string" and Selected or Selected.Name;

			Config.Default = KeyName;

			Keybind.SetValue(Selected);

			IsBinding = false;

			Config.Callback(KeyName);
		end);

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetText(str : string)
			Block:SetText(str or Config.Name);
		end;

		function Args:GetText()
			return Block:GetText();
		end;

		function Args:SetValue(value)
			Config.Default = value;

			Keybind.SetValue(Config.Default);

			Config.Callback(Config.Default);
		end;

		Args.Signal = Signal:Connect(function(bool)
			Block:SetVisible(bool);
		end);

		Args.Link = Compkiller:_LoadOption(Block);

		function Args:GetValue()
			return (typeof(Config.Default) == "string" and Config.Default) or Config.Default.Name;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddColorPicker(Config: ColorPicker)
		Config = Compkiller.__CONFIG(Config,{
			Name = "ColorPicker",
			Default = Color3.fromRGB(255,255,255),
			Flag = nil,
			Transparency = 0,
			Callback = function() end;
		});

		local Block = Compkiller:_CreateBlock(Signal);

		Block:SetParent(Parent);

		Block:SetText(Config.Name);

		Block:SetLine(EnabledLine);

		Block:SetVisible(Signal:GetValue());

		local ColorPicker:Frame , ColorFrame: Frame = Block:AddLink('ColorPicker' , Config.Default);

		local Button = Compkiller:_Input(ColorPicker);

		local ColorPicker = Compkiller:_AddColorPickerPanel(Button,function(color,opc)
			Config.Default = color;
			Config.Transparency = opc;

			ColorFrame.BackgroundColor3 = color;
			ColorFrame.BackgroundTransparency = opc;

			Config.Callback(Config.Default , Config.Transparency);
		end);

		ColorPicker:SetColor(Config.Default,Config.Transparency);
		ColorPicker:Update()

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(value,opc)
			Config.Default = value;
			Config.Transparency = opc;

			ColorPicker:SetColor(value,opc);
			ColorPicker:Update();

			Config.Callback(value,opc);
		end;

		function Args:SetText(str : string)
			Block:SetText(str or Config.Name);
		end;

		function Args:GetText()
			return Block:GetText();
		end;

		Args.Signal = Signal:Connect(function(bool)
			Block:SetVisible(bool);
		end);

		Args.Link = Compkiller:_LoadOption(Block);

		function Args:GetValue()
			return {
				ColorPicker = {
					Color = Config.Default,
					Transparency = Config.Transparency
				}
			};
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddButton(Config: Button)
		Config = Compkiller.__CONFIG(Config , {
			Name = 'Button',
			Callback = function() end
		});

		local Button = Instance.new("Frame")
		local BlockLine = Instance.new("Frame")
		local Frame = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local TextLabel = Instance.new("TextLabel")

		if Compkiller:_IsMobile() then
			Compkiller:_AddDragBlacklist(Button);
		end;

		Button.Name = Compkiller:_RandomString()
		Button.Parent = Parent
		Button.BackgroundTransparency = 1.000
		Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Button.BorderSizePixel = 0
		Button.Size = UDim2.new(1, -1, 0, 30)
		Button.ZIndex = Zindex + 5

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = Button
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 6

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		Frame.Parent = Button
		Frame.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame.BackgroundColor3 = Compkiller.Colors.Highlight
		Frame.BackgroundTransparency = 0.100
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		Frame.Size = UDim2.new(1, -15, 1, -5)
		Frame.ZIndex = Zindex + 7;

		table.insert(Compkiller.Elements.Highlight,{
			Element = Frame,
			Property = "BackgroundColor3"
		});

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = Frame

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = Frame

		TextLabel.Parent = Frame
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.ZIndex = Zindex + 8
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = Config.Name;
		TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TextLabel.TextSize = 12.000
		TextLabel.TextStrokeTransparency = 0.900

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TextLabel,
			Property = 'TextColor3'
		});

		Compkiller:_Hover(Frame,function()
			if Signal:GetValue() then
				Compkiller:_Animation(Frame,TweenInfo.new(0.2),{
					BackgroundTransparency = 0
				})
			end;
		end,function()
			if Signal:GetValue() then
				Compkiller:_Animation(Frame,TweenInfo.new(0.2),{
					BackgroundTransparency = 0.1
				})
			end;
		end);

		Compkiller:_Input(Frame,function()
			Config.Callback();
		end);

		local Args = {};

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(BlockLine, TweenInfo.new(0.35),{
					BackgroundTransparency = 0.500
				});

				Compkiller:_Animation(Frame, TweenInfo.new(0.35),{
					BackgroundTransparency = 0.1
				});

				Compkiller:_Animation(UIStroke, TweenInfo.new(0.35),{
					Transparency = 0
				});

				Compkiller:_Animation(TextLabel, TweenInfo.new(0.35),{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0
				});

			else
				Compkiller:_Animation(BlockLine, TweenInfo.new(0.35),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(Frame, TweenInfo.new(0.35),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(UIStroke, TweenInfo.new(0.35),{
					Transparency = 1
				});

				Compkiller:_Animation(TextLabel, TweenInfo.new(0.35),{
					TextStrokeTransparency = 1,
					TextTransparency = 1
				});
			end;
		end);

		function Args:SetText(t)
			Config.Name = t;
			TextLabel.Text = Config.Name;
		end;

		function Args:GetText()
			return TextLabel.Text;
		end;

		return Args;
	end;

	function Args:AddSlider(Config: Slider)
		Config = Compkiller.__CONFIG(Config , {
			Name = 'Slider',
			Default = 50,
			Min = 0,
			Max = 100,
			Type = "",
			Round = 0,
			Callback = function() end
		});

		local Slider = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local BlockLine = Instance.new("Frame")
		local SliderBar = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local SliderInput = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local Frame = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local UIScale = Instance.new("UIScale")
		local ValueText = Instance.new("TextLabel")

		Compkiller:_AddDragBlacklist(Slider);

		Slider.Name = Compkiller:_RandomString()
		Slider.Parent = Parent
		Slider.BackgroundTransparency = 1.000
		Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Slider.BorderSizePixel = 0
		Slider.Size = UDim2.new(1, -1, 0, 45)
		Slider.ZIndex = Zindex + 1

		BlockText.Name = Compkiller:_RandomString()
		BlockText.Parent = Slider
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 12, 0, 1)
		BlockText.Size = UDim2.new(1, -20, 0, 25)
		BlockText.ZIndex = Zindex + 2
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = Config.Name
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 14.000
		BlockText.TextTransparency = 0.100
		BlockText.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = BlockText,
			Property = 'TextColor3'
		});

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = Slider
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 2
		BlockLine.Visible = EnabledLine or false;

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		SliderBar.Name = Compkiller:_RandomString()
		SliderBar.Parent = Slider
		SliderBar.AnchorPoint = Vector2.new(0.5, 1)
		SliderBar.BackgroundColor3 = Compkiller.Colors.DropColor
		SliderBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SliderBar.BorderSizePixel = 0
		SliderBar.ClipsDescendants = true
		SliderBar.Position = UDim2.new(0.5, 0, 1, -9)
		SliderBar.Size = UDim2.new(1, -25, 0, 10)
		SliderBar.ZIndex = Zindex + 3

		table.insert(Compkiller.Elements.DropColor , {
			Element = SliderBar,
			Property = "BackgroundColor3"
		})

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = SliderBar

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = SliderBar

		SliderInput.Name = Compkiller:_RandomString()
		SliderInput.Parent = SliderBar
		SliderInput.AnchorPoint = Vector2.new(0, 0.5)
		SliderInput.BackgroundColor3 = Compkiller.Colors.Highlight
		SliderInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SliderInput.BorderSizePixel = 0
		SliderInput.Position = UDim2.new(0, 0, 0.5, 0)
		SliderInput.Size = UDim2.new(math.max((Config.Default - Config.Min) / (Config.Max - Config.Min) , 0.045), 0, 1, 0)
		SliderInput.ZIndex = Zindex + 4

		table.insert(Compkiller.Elements.Highlight,{
			Element = SliderInput,
			Property = "BackgroundColor3"
		});

		UICorner_2.CornerRadius = UDim.new(0, 6)
		UICorner_2.Parent = SliderInput

		Frame.Parent = SliderInput
		Frame.AnchorPoint = Vector2.new(1, 0.5)
		Frame.BackgroundColor3 = Compkiller.Colors.SwitchColor
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(1, 5, 0.5, 0)
		Frame.Rotation = 45.000
		Frame.Size = UDim2.new(1, 0, 1, 0)
		Frame.SizeConstraint = Enum.SizeConstraint.RelativeYY
		Frame.ZIndex = Zindex + 6

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = Frame,
			Property = 'BackgroundColor3'
		});

		UICorner_3.CornerRadius = UDim.new(3, 0)
		UICorner_3.Parent = Frame

		UIScale.Parent = Frame
		UIScale.Scale = 1.300

		ValueText.Name = Compkiller:_RandomString()
		ValueText.Parent = Slider
		ValueText.BackgroundTransparency = 1.000
		ValueText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueText.BorderSizePixel = 0
		ValueText.Position = UDim2.new(0, 12, 0, 1)
		ValueText.Size = UDim2.new(1, -20, 0, 25)
		ValueText.ZIndex = Zindex + 4
		ValueText.Font = Enum.Font.GothamMedium
		ValueText.Text = tostring(Config.Default)..tostring(Config.Type)
		ValueText.TextColor3 = Compkiller.Colors.SwitchColor
		ValueText.TextSize = 12.000
		ValueText.TextTransparency = 0.750
		ValueText.TextXAlignment = Enum.TextXAlignment.Right

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = ValueText,
			Property = 'TextColor3'
		});

		Compkiller:_Hover(SliderBar,function()
			if Signal:GetValue() then
				Compkiller:_Animation(ValueText,TweenInfo.new(0.2),{
					TextTransparency = 0.2
				})
			end;
		end,function()
			if Signal:GetValue() then
				Compkiller:_Animation(ValueText,TweenInfo.new(0.2),{
					TextTransparency = 0.750
				})
			end;
		end)	

		local IsHold = false;

		local Update = function(Input)
			local SizeScale = math.clamp((((Input.Position.X) - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X), 0, 1);

			local Main = ((Config.Max - Config.Min) * SizeScale) + Config.Min;

			local Value = Compkiller:_Rounding(Main,Config.Round);

			local PositionX = UDim2.fromScale(SizeScale, 1);

			local Size = (Value - Config.Min) / (Config.Max - Config.Min);

			TweenService:Create(SliderInput , TweenInfo.new(0.2),{
				Size = UDim2.new(math.clamp(Size,0.045,1), 0, 1, 0)
			}):Play();

			Config.Default = Value;

			ValueText.Text = tostring(Config.Default)..tostring(Config.Type)

			Config.Callback(Value)
		end;

		do
			SliderBar.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					IsHold = true
					Update(Input)
				end
			end)

			SliderBar.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if UserInputService.TouchEnabled then
						if not Compkiller:_IsMouseOverFrame(SliderBar) then
							IsHold = false
						end;
					else
						IsHold = false
					end;
				end
			end)

			UserInputService.InputChanged:Connect(function(Input)
				if IsHold then
					if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)  then
						if UserInputService.TouchEnabled then
							if not Compkiller:_IsMouseOverFrame(SliderBar) then
								IsHold = false
							else
								Update(Input)
							end;
						else
							Update(Input)
						end;
					end;
				end;
			end);
		end;

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(Value)
			Config.Default = Value;

			ValueText.Text = tostring(Config.Default)..tostring(Config.Type)

			Compkiller:_Animation(SliderInput, TweenInfo.new(0.35),{
				Size = UDim2.new(math.max((Config.Default - Config.Min) / (Config.Max - Config.Min) , 0.045), 0, 1, 0)
			});

			Config.Callback(Value);
		end;

		function Args:SetText(str : string)
			BlockText.Text = str or Config.Name
		end;

		function Args:GetText()
			return BlockText.Text;
		end;

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(SliderInput, TweenInfo.new(0.35),{
					Size = UDim2.new(math.max((Config.Default - Config.Min) / (Config.Max - Config.Min) , 0.045), 0, 1, 0)
				});

				Compkiller:_Animation(ValueText,Tween,{
					TextTransparency = 0.750
				})

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(SliderInput,Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(UIStroke,Tween,{
					Transparency = 0
				})

				Compkiller:_Animation(SliderBar,Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(BlockLine,Tween,{
					BackgroundTransparency = 0.5
				})

				Compkiller:_Animation(BlockText,Tween,{
					TextTransparency = 0.1
				})
			else
				Compkiller:_Animation(SliderInput, TweenInfo.new(0.35),{
					Size = UDim2.new(0, 0, 1, 0)
				});

				Compkiller:_Animation(ValueText,Tween,{
					TextTransparency = 1
				})

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(SliderInput,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(UIStroke,Tween,{
					Transparency = 1
				})

				Compkiller:_Animation(SliderBar,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(BlockLine,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(BlockText,Tween,{
					TextTransparency = 1
				})
			end;
		end);

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		if not DisableStackKeybind then
			local AutoKeybind = Compkiller:_KeybindHandler(Slider , "Number" , Args , Signal , Zindex , Config);

			Args.AutoKeybind = AutoKeybind;
		end;

		return Args;
	end;

	function Args:AddParagraph(Config: Paragraph) -- request by Neptune
		Config = Compkiller.__CONFIG(Config, {
			Title = "Paragraph",
			Content = "",
		});

		local Paragraph = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local BlockLine = Instance.new("Frame")
		local DescriptionText = Instance.new("TextLabel")

		if Compkiller:_IsMobile() then
			Compkiller:_AddDragBlacklist(Paragraph);
		end;

		Paragraph.Name = Compkiller:_RandomString()
		Paragraph.Parent = Parent
		Paragraph.BackgroundTransparency = 1.000
		Paragraph.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Paragraph.BorderSizePixel = 0
		Paragraph.Size = UDim2.new(1, -1, 0, 40)
		Paragraph.ZIndex = Zindex + 2
		Paragraph.ClipsDescendants = true

		BlockText.Name = Compkiller:_RandomString()
		BlockText.Parent = Paragraph
		BlockText.AnchorPoint = Vector2.new(0, 0.5)
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 12, 0, 12)
		BlockText.Size = UDim2.new(1, -20, 0, 25)
		BlockText.ZIndex = Zindex + 3
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = Config.Title
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 14.000
		BlockText.TextTransparency = 0.300
		BlockText.TextXAlignment = Enum.TextXAlignment.Left
		BlockText.RichText = true

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = BlockText,
			Property = 'TextColor3'
		});

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = Paragraph
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 4

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		DescriptionText.RichText = true
		DescriptionText.Name = Compkiller:_RandomString()
		DescriptionText.Parent = Paragraph
		DescriptionText.BackgroundTransparency = 1.000
		DescriptionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DescriptionText.BorderSizePixel = 0
		DescriptionText.Position = UDim2.new(0, 12, 0, 22)
		DescriptionText.Size = UDim2.new(1, -20, 1, -25)
		DescriptionText.ZIndex = Zindex + 5
		DescriptionText.Font = Enum.Font.GothamMedium
		DescriptionText.Text = Config.Content
		DescriptionText.TextColor3 = Compkiller.Colors.SwitchColor
		DescriptionText.TextSize = 13.000
		DescriptionText.TextTransparency = 0.500
		DescriptionText.TextXAlignment = Enum.TextXAlignment.Left
		DescriptionText.TextYAlignment = Enum.TextYAlignment.Top

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = DescriptionText,
			Property = 'TextColor3'
		});

		local Base = 15;

		local UpdateScale = function()

			if not DescriptionText.Text:byte() then
				local TitleScale = TextService:GetTextSize(BlockText.Text,BlockText.TextSize,BlockText.Font,Vector2.new(math.huge,math.huge));

				Compkiller:_Animation(Paragraph,TweenInfo.new(0.15),{
					Size = UDim2.new(1, -1, 0, TitleScale.Y + Base)
				});
			else
				local TitleScale = TextService:GetTextSize(BlockText.Text,BlockText.TextSize,BlockText.Font,Vector2.new(math.huge,math.huge));
				local ContentScale = TextService:GetTextSize(DescriptionText.Text,DescriptionText.TextSize,DescriptionText.Font,Vector2.new(math.huge,math.huge));

				Compkiller:_Animation(Paragraph,TweenInfo.new(0.15),{
					Size = UDim2.new(1, -1, 0, (TitleScale.Y + ContentScale.Y) + Base)
				});
			end;
		end;

		UpdateScale();

		local Args = {};

		function Args:SetTitle(title)
			BlockText.Text = title;
			UpdateScale();
		end;

		function Args:SetContent(content)
			DescriptionText.Text = content;
			UpdateScale();
		end;

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 0.300
				});

				Compkiller:_Animation(DescriptionText,TweenInfo.new(0.2),{
					TextTransparency = 0.500
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 0.500
				});
			else
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(DescriptionText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 1
				});
			end;
		end);

		return Args;
	end;

	function Args:AddTextBox(Config: TextBoxConfig)
		Config = Compkiller.__CONFIG(Config , {
			Name = "TextBox",
			Default = "",
			Placeholder = "Placeholder",
			Numberic = false,
			Callback = function() end,
		});

		local TextBox = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local LinkValues = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local TextBox_2 = Instance.new("TextBox")
		local BlockLine = Instance.new("Frame")

		if Compkiller:_IsMobile() then
			Compkiller:_AddDragBlacklist(TextBox);
		end;

		TextBox.Name = Compkiller:_RandomString()
		TextBox.Parent = Parent
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Size = UDim2.new(1, -1, 0, 30)
		TextBox.ZIndex = Zindex + 1

		BlockText.Name = Compkiller:_RandomString()
		BlockText.Parent = TextBox
		BlockText.AnchorPoint = Vector2.new(0, 0.5)
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 12, 0.5, 0)
		BlockText.Size = UDim2.new(1, -20, 0, 25)
		BlockText.ZIndex = Zindex + 2
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = Config.Name
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 14.000
		BlockText.TextTransparency = 0.300
		BlockText.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor,{
			Element = BlockText,
			Property = "TextColor3"
		})

		LinkValues.Name = Compkiller:_RandomString()
		LinkValues.Parent = TextBox
		LinkValues.AnchorPoint = Vector2.new(1, 0.540000021)
		LinkValues.BackgroundColor3 = Compkiller.Colors.DropColor
		LinkValues.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LinkValues.BorderSizePixel = 0
		LinkValues.Position = UDim2.new(1, -12, 0.5, 0)
		LinkValues.Size = UDim2.new(0, 95, 0, 16)
		LinkValues.ZIndex = Zindex + 3

		table.insert(Compkiller.Elements.DropColor,{
			Element = LinkValues,
			Property = "BackgroundColor3"
		})

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = LinkValues

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		})

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = LinkValues

		TextBox_2.Parent = LinkValues
		TextBox_2.AnchorPoint = Vector2.new(0.5, 0.5)
		TextBox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox_2.BackgroundTransparency = 1.000
		TextBox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox_2.BorderSizePixel = 0
		TextBox_2.ClipsDescendants = true
		TextBox_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextBox_2.Size = UDim2.new(1, -5, 1, 0)
		TextBox_2.ZIndex = Zindex + 5
		TextBox_2.ClearTextOnFocus = false
		TextBox_2.Font = Enum.Font.GothamMedium
		TextBox_2.PlaceholderText = Config.Placeholder
		TextBox_2.Text = Config.Default
		TextBox_2.TextColor3 = Compkiller.Colors.SwitchColor
		TextBox_2.TextSize = 11.000

		table.insert(Compkiller.Elements.SwitchColor,{
			Element = TextBox_2,
			Property = "TextColor3"
		})

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = TextBox
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 3;

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		})

		local Update = function()
			local scale = TextService:GetTextSize(TextBox_2.Text,TextBox_2.TextSize,TextBox_2.Font,Vector2.new(math.huge,math.huge));
			local Base = TextService:GetTextSize(TextBox_2.PlaceholderText,TextBox_2.TextSize,TextBox_2.Font,Vector2.new(math.huge,math.huge));

			local MainScale = ((scale.X > Base.X) and scale.X) or Base.X;

			local CurrentScale = (Compkiller.MainUIScale and Compkiller.MainUIScale.Scale) or 1;
			local xp = pcall(function()
				Compkiller:_Animation(LinkValues,TweenInfo.new(0.25),{
					Size = UDim2.fromOffset(math.clamp((MainScale + 7) / CurrentScale , Base.X / CurrentScale , (TextBox.AbsoluteSize.X / CurrentScale) / 2) , 16)
				})
			end);

			if not xp then
				Compkiller:_Animation(LinkValues,TweenInfo.new(0.25),{
					Size = UDim2.fromOffset((MainScale + 7) / CurrentScale , 16)
				})
			end;
		end;

		local parse = function(text)
			if not text then
				return "";	
			end;

			if Config.Numeric then
				local out = string.gsub(tostring(text), '[^0-9.]', '')

				if tonumber(out) then
					return tonumber(out);
				end;

				return nil;
			end;

			return text;
		end;

		Update();

		TextBox_2:GetPropertyChangedSignal('Text'):Connect(Update);

		TextBox_2:GetPropertyChangedSignal('Text'):Connect(function()
			local value = parse(TextBox_2.Text);

			if value then

				TextBox_2.Text = tostring(value);

				task.spawn(Config.Callback,value);

				Config.Default = value;
			else
				TextBox_2.Text = string.gsub(TextBox_2.Text, '[^0-9.]', '');

				Config.Default = TextBox_2.Text;
			end;
		end);

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetText(str : string)
			BlockText.Text = str or Config.Name
		end;

		function Args:GetText()
			return BlockText.Text;
		end;

		function Args:SetValue(Value)
			Config.Default = Value;

			TextBox_2.Text = tostring(Config.Default);

			Config.Callback(Value);
		end;

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 0.3
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 0.5
				});

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Transparency = 0
				});

				Compkiller:_Animation(LinkValues,TweenInfo.new(0.2),{
					BackgroundTransparency = 0
				});

			else
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Transparency = 1
				});

				Compkiller:_Animation(LinkValues,TweenInfo.new(0.2),{
					BackgroundTransparency = 1
				});

			end;
		end);

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddDropdown(Config : Dropdown)
		Config = Compkiller.__CONFIG(Config,{
			Name = "Dropdown",
			Default = nil,
			Values = {"Item 1","Item 2","Item 3"},
			Multi = false,
			Callback = function() end;
		});

		local DaTabarser = function(value)
			if not value then return ''; end;

			local Out;

			if typeof(value) == 'table' then
				if #value > 0 then
					local x = {};

					for i,v in next , value do
						table.insert(x , tostring(v))
					end;

					Out = table.concat(x,' , ');
				else
					local x = {};

					for i,v in next , value do
						if v == true then
							table.insert(x , tostring(i));
						end			
					end;

					Out = table.concat(x,' , ');
				end;
			else
				Out = tostring(value);
			end;

			return Out;
		end;

		local Dropdown = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local BlockLine = Instance.new("Frame")
		local LinkValues = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local ValueItems = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local ValueText = Instance.new("TextLabel")
		local MainButton = Instance.new("ImageButton")

		Dropdown.Name = Compkiller:_RandomString()
		Dropdown.Parent = Parent
		Dropdown.BackgroundTransparency = 1.000
		Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Dropdown.BorderSizePixel = 0
		Dropdown.Size = UDim2.new(1, -1, 0, 55)
		Dropdown.ZIndex = Zindex + 2

		BlockText.Name = Compkiller:_RandomString()
		BlockText.Parent = Dropdown
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 12, 0, 1)
		BlockText.Size = UDim2.new(1, -20, 0, 25)
		BlockText.ZIndex = Zindex + 3
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = Config.Name
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 14.000
		BlockText.TextTransparency = 0.100
		BlockText.TextXAlignment = Enum.TextXAlignment.Left

		if not BlockText.Text:byte() then
			Dropdown.Size = UDim2.new(1, -1, 0, 25)
		end;

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = BlockText,
			Property = 'TextColor3'
		});

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = Dropdown
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 3

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		LinkValues.Name = Compkiller:_RandomString()
		LinkValues.Parent = Dropdown
		LinkValues.AnchorPoint = Vector2.new(1, 0.540000021)
		LinkValues.BackgroundTransparency = 1.000
		LinkValues.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LinkValues.BorderSizePixel = 0
		LinkValues.Position = UDim2.new(1, -12, 0, 15)
		LinkValues.Size = UDim2.new(1, 0, 0, 18)
		LinkValues.ZIndex = Zindex + 3

		UIListLayout.Parent = LinkValues
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 8)

		ValueItems.Name = Compkiller:_RandomString()
		ValueItems.Parent = Dropdown
		ValueItems.AnchorPoint = Vector2.new(0.5, 1)
		ValueItems.BackgroundColor3 = Compkiller.Colors.DropColor
		ValueItems.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueItems.BorderSizePixel = 0
		ValueItems.ClipsDescendants = true
		ValueItems.Position = UDim2.new(0.5, 0, 1, -7)
		ValueItems.Size = UDim2.new(1, -25, 0, 18)
		ValueItems.ZIndex = Zindex + 5

		table.insert(Compkiller.Elements.DropColor , {
			Element = ValueItems,
			Property = "BackgroundColor3"
		})

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = ValueItems

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = ValueItems

		ValueText.Name = Compkiller:_RandomString()
		ValueText.Parent = ValueItems
		ValueText.AnchorPoint = Vector2.new(0.5, 0.5)
		ValueText.BackgroundTransparency = 1.000
		ValueText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueText.BorderSizePixel = 0
		ValueText.Position = UDim2.new(0.5, 0, 0.5, 0)
		ValueText.Size = UDim2.new(1, -10, 0, 15)
		ValueText.ZIndex = Zindex + 8
		ValueText.Font = Enum.Font.Gotham
		ValueText.Text = DaTabarser(Config.Default)
		ValueText.TextColor3 = Compkiller.Colors.SwitchColor
		ValueText.TextSize = 11.000
		ValueText.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = ValueText,
			Property = 'TextColor3'
		});

		MainButton.Name = Compkiller:_RandomString()
		MainButton.Parent = ValueItems
		MainButton.AnchorPoint = Vector2.new(1, 0.5)
		MainButton.BackgroundTransparency = 1.000
		MainButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MainButton.BorderSizePixel = 0
		MainButton.Position = UDim2.new(1, -5, 0.5, 0)
		MainButton.Size = UDim2.new(0, 13, 0, 13)
		MainButton.ZIndex = Zindex + 5
		MainButton.Image = Compkiller:CacheImage("rbxassetid://109535175596957")

		Compkiller:_Hover(ValueItems,function()
			Compkiller:_Animation(ValueItems,TweenInfo.new(0.3),{
				BackgroundColor3 = Compkiller.Colors.MouseEnter
			});
		end,function()
			Compkiller:_Animation(ValueItems,TweenInfo.new(0.3),{
				BackgroundColor3 = Compkiller.Colors.DropColor
			});
		end);

		local repi;
		local Button = Compkiller:_Input(ValueItems);

		repi = Compkiller:_LoadDropdown(Button,function(value)
			Config.Default = value;

			repi:SetData(Config.Default,Config.Values,Config.Multi,false);
			repi:SetDefault(Config.Default);

			ValueText.Text = DaTabarser(Config.Default);

			Config.Callback(Config.Default);
		end);

		repi.EventOut:Connect(function(v)
			if v then
				Compkiller:_Animation(MainButton,TweenInfo.new(0.2),{
					Rotation = -180
				})
			else
				Compkiller:_Animation(MainButton,TweenInfo.new(0.2),{
					Rotation = 0
				})
			end;
		end)

		repi:SetData(Config.Default,Config.Values,Config.Multi,false);
		repi:Refersh();

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(Value)
			Config.Default = Value;

			ValueText.Text = DaTabarser(Config.Default);

			repi:SetData(Config.Default,Config.Values,Config.Multi,true);

			Config.Callback(Value);
		end;

		function Args:SetText(str : string)
			BlockText.Text = str or Config.Name
		end;


		function Args:GetText()
			return BlockText.Text;
		end;

		function Args:SetValues(v)
			Config.Values = v;

			repi:SetData(Config.Default,Config.Values,Config.Multi,true);
		end;

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 0.100
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 0.100
				});

				Compkiller:_Animation(ValueItems,TweenInfo.new(0.2),{
					BackgroundTransparency = 0
				});

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Transparency = 0
				});

				Compkiller:_Animation(ValueText,TweenInfo.new(0.32),{
					TextTransparency = 0
				});

				Compkiller:_Animation(MainButton,TweenInfo.new(0.2),{
					ImageTransparency = 0
				});
			else
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 1 
				});

				Compkiller:_Animation(ValueItems,TweenInfo.new(0.2),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Transparency = 1
				});

				Compkiller:_Animation(ValueText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(MainButton,TweenInfo.new(0.2),{
					ImageTransparency = 1
				});
			end;
		end);

		Args.Link = Compkiller:_LoadOption({
			AddLink = function(self ,Name , Default)
				return Compkiller:_AddLinkValue(Name , Default , LinkValues , LinkValues , {
					Tween = TweenInfo.new(0.2)	
				} , Signal);
			end,
			Root = Dropdown
		});

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	return Args;
end;

function Compkiller:GetTheme()
	return Compkiller.Colors;
end;

function Compkiller:SetTheme(name)
	if name == "Dark Green" then
		Compkiller.Colors = {
			["BGDBColor"] = Color3.new(0.0429964, 0.110345, 0.0727226),
			["BlockBackground"] = Color3.new(0.159287, 0.234483, 0.201811),
			["BlockColor"] = Color3.new(0, 0.137931, 0.0951249),
			["DropColor"] = Color3.new(0, 0.227586, 0.100452),
			["Highlight"] = Color3.new(0.0666667, 0.992157, 0.628343),
			["LineColor"] = Color3.new(0.263258, 0.372414, 0.329504),
			["MouseEnter"] = Color3.new(0, 0.841379, 0.51063),
			["Risky"] = Color3.new(1, 0.398296, 0.152941),
			["StrokeColor"] = Color3.new(0.132342, 0.241379, 0.198517),
			["SwitchColor"] = Color3.new(0.927586, 1, 0.980523),
			["Toggle"] = Color3.new(0, 0.613793, 0.220119),
			HighStrokeColor = Color3.new(0, 0.241379, 0.186445),
		};
	elseif name == "Default" then
		Compkiller.Colors = {
			Highlight = Color3.fromRGB(128, 128, 128),
			Toggle = Color3.fromRGB(100, 100, 100),
			Risky = Color3.fromRGB(255, 255, 0),
			BGDBColor = Color3.fromRGB(15, 15, 15),
			BlockColor = Color3.fromRGB(25, 25, 25),
			StrokeColor = Color3.fromRGB(45, 45, 45),
			SwitchColor = Color3.fromRGB(220, 220, 220),
			DropColor = Color3.fromRGB(30, 30, 30),
			MouseEnter = Color3.fromRGB(50, 50, 50),
			BlockBackground = Color3.fromRGB(20, 20, 20),
			LineColor = Color3.fromRGB(60, 60, 60),
			HighStrokeColor = Color3.fromRGB(70, 70, 70),
		};
	elseif name == "Dark Blue" then
		Compkiller.Colors = {
			["BGDBColor"] = Color3.new(0.0393817, 0.0754204, 0.165517),
			["BlockBackground"] = Color3.new(0, 0.0618311, 0.172414),
			["BlockColor"] = Color3.new(0, 0.0172414, 0.103448),
			["DropColor"] = Color3.new(0, 0.0965518, 0.289655),
			["HighStrokeColor"] = Color3.new(0, 0.132604, 0.234483),
			["Highlight"] = Color3.new(0.0666667, 0.781528, 0.992157),
			["LineColor"] = Color3.new(0, 0.110345, 0.275862),
			["MouseEnter"] = Color3.new(0, 0.606896, 1),
			["Risky"] = Color3.new(0.0310345, 0.819572, 1),
			["StrokeColor"] = Color3.new(0, 0.119857, 0.248276),
			["SwitchColor"] = Color3.new(1, 1, 1),
			["Toggle"] = Color3.new(0.054902, 0.463935, 0.835294)
		}
	elseif name == "Purple Premium" then
		Compkiller.Colors = {
			["Highlight"] = Color3.fromRGB(160, 120, 255),
			["Toggle"] = Color3.fromRGB(140, 100, 235),
			["Risky"] = Color3.fromRGB(255, 200, 60),
			["BGDBColor"] = Color3.fromRGB(18, 18, 24),
			["BlockColor"] = Color3.fromRGB(24, 24, 32),
			["StrokeColor"] = Color3.fromRGB(40, 38, 50),
			["DropColor"] = Color3.fromRGB(30, 28, 38),
			["MouseEnter"] = Color3.fromRGB(50, 45, 65),
			["BlockBackground"] = Color3.fromRGB(34, 32, 44),
			["LineColor"] = Color3.fromRGB(55, 50, 70),
			["HighStrokeColor"] = Color3.fromRGB(60, 55, 75),
		};
	elseif name == "Purple Rose" then
		Compkiller.Colors = {
			["BGDBColor"] = Color3.new(0.0459068, 0.030321, 0.117241),
			["BlockBackground"] = Color3.new(0.156272, 0.119596, 0.324138),
			["BlockColor"] = Color3.new(0.0948428, 0.0576457, 0.165517),
			["DropColor"] = Color3.new(0.131034, 0, 0.0813317),
			["HighStrokeColor"] = Color3.new(0.136259, 0.101237, 0.296552),
			["Highlight"] = Color3.new(0.992157, 0.0666667, 0.33474),
			["LineColor"] = Color3.new(0.20872, 0.137408, 0.372414),
			["MouseEnter"] = Color3.new(0.365517, 0, 0.120999),
			["Risky"] = Color3.new(1, 0.6086, 0.152941),
			["StrokeColor"] = Color3.new(0.148499, 0.137836, 0.248276),
			["SwitchColor"] = Color3.new(1, 1, 1),
			["Toggle"] = Color3.new(0.835294, 0.054902, 0.248654)
		}
	elseif name == "Skeet" then		
		Compkiller.Colors = {
			["BGDBColor"] = Color3.new(0.114578, 0.125191, 0.151724),
			["BlockBackground"] = Color3.new(0.128181, 0.131124, 0.151724),
			["BlockColor"] = Color3.new(0.0732699, 0.0760008, 0.0896552),
			["DropColor"] = Color3.new(0.0809037, 0.0861197, 0.0965517),
			["HighStrokeColor"] = Color3.new(0.119382, 0.1217, 0.137931),
			["Highlight"] = Color3.new(0, 0.634483, 0.0700119),
			["LineColor"] = Color3.new(0.151724, 0.151724, 0.151724),
			["MouseEnter"] = Color3.new(0.134007, 0.141391, 0.158621),
			["Risky"] = Color3.new(0.984314, 1, 0.152941),
			["StrokeColor"] = Color3.new(0.0769798, 0.0790924, 0.0896552),
			["SwitchColor"] = Color3.new(1, 1, 1),
			["Toggle"] = Color3.new(0, 0.324138, 0.10283)
		}
	end;

	Compkiller:RefreshCurrentColor()
end;

function Compkiller:RefreshCurrentColor()
	for i,v in next , Compkiller.Elements.Highlight do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.Highlight;
		end;
	end;

	for i,v in next , Compkiller.Elements do
		if v.Element and v.Property and v.Element:GetAttribute('Enabled') then
			v.Element[v.Property] = Compkiller.Colors.Highlight;
		end;
	end;

	for i,v in next , Compkiller.Elements.Risky do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.Risky;
		end;
	end;

	for i,v in next , Compkiller.Elements.BlockColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.BlockColor;
		end;
	end;

	for i,v in next , Compkiller.Elements.BGDBColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.BGDBColor;
		end;
	end;

	for i,v in next , Compkiller.Elements.StrokeColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.StrokeColor;
		end;
	end;

	for i,v in next , Compkiller.Elements.SwitchColor do
		if v.Element and v.Property and v.Element[v.Property] ~= Compkiller.Colors.MouseEnter then
			v.Element[v.Property] = Compkiller.Colors.SwitchColor;
		end;
	end;

	for i,v in next , Compkiller.Elements.BlockBackground do
		if v.Element and v.Property and v.Element[v.Property] then
			v.Element[v.Property] = Compkiller.Colors.BlockBackground;
		end;
	end;

	for i,v in next , Compkiller.Elements.DropColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.DropColor;
		end;
	end;

	for i,v in next , Compkiller.Elements.LineColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.LineColor;
		end;
	end;

	for i,v in next , Compkiller.Elements.HighStrokeColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.HighStrokeColor;
		end;
	end;
end;

function Compkiller:ChangeHighlightColor(NewColor: Color3)
	local H,S,V = NewColor:ToHSV();

	Compkiller.Colors.Highlight = NewColor;
	Compkiller.Colors.Toggle = Color3.fromHSV(H,S,V - 0.2);

	for i,v in next , Compkiller.Elements.Highlight do
		if v.Element and v.Property then
			v.Element[v.Property] = NewColor;
		end;
	end;

	for i,v in next , Compkiller.Elements do
		if v.Element and v.Property and v.Element:GetAttribute('Enabled') then
			v.Element[v.Property] = NewColor;
		end;
	end;
end;

function Compkiller.new(Config : Window)

	if not Config.Scale then
		if Compkiller:_IsMobile() then
			Config.Scale = Compkiller.Scale.Mobile;
		else
			Config.Scale = Compkiller.Scale.Window;
		end;
	end;

	Config = Compkiller.__CONFIG(Config , {
		Name = "COMPKILLER",
		Keybind = "Insert",
		Logo = Compkiller.Logo;
		Scale = Compkiller.Scale.Window,
		TextSize = 15,
		AutoScale = false
	});

	local TabHover = Compkiller.__SIGNAL(false);
	local WindowOpen = Compkiller.__SIGNAL(true);
	local WindowArgs = {
		SelectedTab = nil,
		Tabs = {},
		LastTab = nil,
		IsOpen = true,
		AlwayShowTab = false,
		THREADS = {},
		PerformanceMode = false,
		Notify = Compkiller.newNotify(),
		MainUIScale = nil,
	};

	WindowArgs.Username = LocalPlayer.Name;

	if Compkiller:_IsMobile() then
		WindowArgs.AlwayShowTab = true;
	end;

	local CompKiller = Instance.new("ScreenGui")
	local MainFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TabFrame = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local LineFrame1 = Instance.new("Frame")
	local CompLogo = Instance.new("ImageLabel")
	local WindowLabel = Instance.new("TextLabel")
	local TabButtons = Instance.new("Frame")
	local SelectionFrame = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local TabButtonScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local Userinfo = Instance.new("Frame")
	local UserProfile = Instance.new("ImageLabel")
	local UICorner_4 = Instance.new("UICorner")
	local UserText = Instance.new("TextLabel")
	local ExpireText = Instance.new("TextLabel")
	local TabMainFrame = Instance.new("Frame")

	Compkiller:_DrawKeybinds(CompKiller);

	UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		local CurrentScale = (MainUIScale and MainUIScale.Scale) or (Compkiller.MainUIScale and Compkiller.MainUIScale.Scale) or 1;
		TabButtonScrollingFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y / CurrentScale)
	end);

	CompKiller.Name = "u?name=compkiller_?"..Compkiller:_RandomString();
	CompKiller.Parent = CoreGui;
	CompKiller.ResetOnSpawn = false
	CompKiller.IgnoreGuiInset = true;
	CompKiller.ZIndexBehavior = Enum.ZIndexBehavior.Global;

	Compkiller.ProtectGui(CompKiller);

	WindowArgs.Root = CompKiller;

	table.insert(Compkiller.Windows , CompKiller);

	MainFrame.Active = true;
	MainFrame.Name = Compkiller:_RandomString()
	MainFrame.Parent = CompKiller
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Compkiller.Colors.BGDBColor

	table.insert(Compkiller.Elements.BGDBColor,{
		Element = MainFrame,
		Property = 'BackgroundColor3'
	});

	MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BorderSizePixel = 0
	MainFrame.Position = UDim2.fromScale(0.5,0.5);
	MainFrame.Size = Compkiller.Scale.Window
	MainFrame.ZIndex = 4

	MainFrame:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
		if MainFrame.BackgroundTransparency > 0.9 then
			MainFrame.Visible = false;
		else
			MainFrame.Visible = true;
		end;
	end)

	Compkiller:_Animation(MainFrame,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
		Size = Config.Scale
	});

	UICorner.Parent = MainFrame

	local MainUIScale = Instance.new("UIScale")
	MainUIScale.Parent = MainFrame
	Compkiller.MainUIScale = MainUIScale
	WindowArgs.MainUIScale = MainUIScale
	Compkiller.MainUIScale = MainUIScale

	local function UpdateScale()
		if Config.AutoScale then
			local ViewportSize = CurrentCamera.ViewportSize
			local BaseResolution = Vector2.new(1920, 1080)
			local Ratio = math.min(ViewportSize.X / BaseResolution.X, ViewportSize.Y / BaseResolution.Y)
			MainUIScale.Scale = math.clamp(Ratio, 0.5, 1.5)
		else
			MainUIScale.Scale = 1
		end
	end

	UpdateScale()
	CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)

	MainUIScale:GetPropertyChangedSignal("Scale"):Connect(function()
		for obj, func in next, WindowArgs.THREADS do
			if typeof(func) == "function" then
				func()
			end
		end
	end)

	local TabFrameBaseTrans = 0.25;

	TabFrame.Active = true
	TabFrame.Name = Compkiller:_RandomString()
	TabFrame.Parent = MainFrame
	TabFrame.AnchorPoint = Vector2.new(1, 0)
	TabFrame.BackgroundColor3 = Compkiller.Colors.BGDBColor

	table.insert(Compkiller.Elements.BGDBColor,{
		Element = TabFrame,
		Property = 'BackgroundColor3'
	});

	TabFrame.BackgroundTransparency = TabFrameBaseTrans
	TabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabFrame.BorderSizePixel = 0
	TabFrame.ClipsDescendants = true
	TabFrame.Position = UDim2.new(0, 25, 0, 0)
	TabFrame.Size = UDim2.new(0, 85, 1, 0)

	UICorner_2.Parent = TabFrame

	LineFrame1.Name = Compkiller:_RandomString()
	LineFrame1.Parent = TabFrame
	LineFrame1.AnchorPoint = Vector2.new(1, 0)
	LineFrame1.BackgroundColor3 = Compkiller.Colors.BGDBColor

	table.insert(Compkiller.Elements.BGDBColor,{
		Element = LineFrame1,
		Property = 'BackgroundColor3'
	});

	LineFrame1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame1.BorderSizePixel = 0
	LineFrame1.Position = UDim2.new(1, 0, 0, 0)
	LineFrame1.Size = UDim2.new(0, 2, 1, 0)

	CompLogo.Name = Compkiller:_RandomString()
	CompLogo.Parent = TabFrame
	CompLogo.BackgroundTransparency = 1.000
	CompLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CompLogo.BorderSizePixel = 0
	CompLogo.AnchorPoint = Vector2.new(0.5, 0.5)
	CompLogo.Position = UDim2.new(0.5, -12, 0, 45) -- Fine-tuned center
	CompLogo.Size = UDim2.new(0, 40, 0, 32) -- Bigger, fits sidebar (left=10.5, right=50.5)
	CompLogo.Image = Config.Logo
	CompLogo.ScaleType = Enum.ScaleType.Fit
	CompLogo.ImageColor3 = Color3.new(1,1,1)
	CompLogo.ZIndex = 4
	
	WindowLabel.Name = Compkiller:_RandomString()
	WindowLabel.Parent = TabFrame
	WindowLabel.BackgroundTransparency = 1.000
	WindowLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowLabel.BorderSizePixel = 0
	WindowLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	WindowLabel.Position = UDim2.new(0.5, -12, 0, 45) -- Aligned with logo
	WindowLabel.Size = UDim2.new(1, -10, 0, 25)
	WindowLabel.TextTransparency = 1 -- Hide text in collapsed mode
	WindowLabel.Font = Enum.Font.GothamBold
	WindowLabel.Text = Config.Name
	WindowLabel.TextColor3 = Compkiller.Colors.SwitchColor
	WindowLabel.TextSize = Config.TextSize
	WindowLabel.TextXAlignment = Enum.TextXAlignment.Center

	table.insert(Compkiller.Elements.SwitchColor , {
		Element = WindowLabel,
		Property = 'TextColor3'
	});

	TabButtons.Name = Compkiller:_RandomString()
	TabButtons.Parent = TabFrame
	TabButtons.BackgroundTransparency = 1.000
	TabButtons.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabButtons.BorderSizePixel = 0
	TabButtons.Position = UDim2.new(0, 0, 0, 90)
	TabButtons.Size = UDim2.new(1, 0, 1, -155)

	SelectionFrame.Name = Compkiller:_RandomString()
	SelectionFrame.Parent = TabButtons
	SelectionFrame.AnchorPoint = Vector2.new(1, 0)
	SelectionFrame.BackgroundColor3 = Compkiller.Colors.Highlight
	SelectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SelectionFrame.BorderSizePixel = 0
	SelectionFrame.Position = UDim2.new(1, 0, 0, 28)
	SelectionFrame.Size = UDim2.new(0, 3, 0, 27)

	table.insert(Compkiller.Elements.Highlight,{
		Element = SelectionFrame,
		Property = "BackgroundColor3"
	});

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = SelectionFrame

	TabButtonScrollingFrame.Name = Compkiller:_RandomString()
	TabButtonScrollingFrame.Parent = TabButtons
	TabButtonScrollingFrame.Active = true
	TabButtonScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	TabButtonScrollingFrame.BackgroundTransparency = 1.000
	TabButtonScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabButtonScrollingFrame.BorderSizePixel = 0
	TabButtonScrollingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	TabButtonScrollingFrame.Size = UDim2.new(1, 0, 1, -5)
	TabButtonScrollingFrame.BottomImage = ""
	TabButtonScrollingFrame.ScrollBarThickness = 0
	TabButtonScrollingFrame.TopImage = ""

	UIListLayout.Parent = TabButtonScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)

	Userinfo.Name = Compkiller:_RandomString()
	Userinfo.Parent = TabFrame
	Userinfo.AnchorPoint = Vector2.new(0, 1)
	Userinfo.BackgroundTransparency = 1.000
	Userinfo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Userinfo.BorderSizePixel = 0
	Userinfo.Position = UDim2.new(0, 0, 1, 0)
	Userinfo.Size = UDim2.new(1, -25, 0, 60)

	do
		local Highlight = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")

		Highlight.Name = Compkiller:_RandomString()
		Highlight.Parent = Userinfo
		Highlight.AnchorPoint = Vector2.new(0.5, 0)
		Highlight.BackgroundColor3 = Color3.fromRGB(161, 161, 161)
		Highlight.BackgroundTransparency = 1
		Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Highlight.BorderSizePixel = 0
		Highlight.Position = UDim2.new(0.5, 0, 0, 4)
		Highlight.Size = UDim2.new(1, -15, 1, -15)

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Highlight

		Userinfo.MouseEnter:Connect(function()
			Compkiller:_Animation(Highlight,TweenInfo.new(0.2),{
				BackgroundTransparency = 0.925
			});
		end);

		Userinfo.MouseLeave:Connect(function()
			Compkiller:_Animation(Highlight,TweenInfo.new(0.2),{
				BackgroundTransparency = 1
			});
		end);

		Compkiller:_Input(Userinfo,function()
			if WindowArgs.UserSettings.Root then
				WindowArgs.UserSettings:Window(true);
			end;
		end);
	end;

	UserProfile.Name = Compkiller:_RandomString()
	UserProfile.Parent = Userinfo
	UserProfile.BackgroundTransparency = 1.000
	UserProfile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserProfile.BorderSizePixel = 0
	UserProfile.Position = UDim2.new(0, 10, 0, 9)
	UserProfile.Size = UDim2.new(0, 35, 0, 35)
	UserProfile.ZIndex = 2
	UserProfile.Image = Compkiller:CacheImage("rbxassetid://18518299306")

	UICorner_4.CornerRadius = UDim.new(1, 0)
	UICorner_4.Parent = UserProfile

	UserText.Name = Compkiller:_RandomString()
	UserText.Parent = Userinfo
	UserText.BackgroundTransparency = 1.000
	UserText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserText.BorderSizePixel = 0
	UserText.Position = UDim2.new(0, 55, 0, 8)
	UserText.Size = UDim2.new(0, 200, 0, 20)
	UserText.ZIndex = 2
	UserText.Font = Enum.Font.GothamMedium
	UserText.Text = "Username"
	UserText.TextColor3 = Compkiller.Colors.SwitchColor
	UserText.TextSize = 13.000
	UserText.TextXAlignment = Enum.TextXAlignment.Left

	table.insert(Compkiller.Elements.SwitchColor , {
		Element = UserText,
		Property = 'TextColor3'
	});

	ExpireText.Name = Compkiller:_RandomString()
	ExpireText.Parent = Userinfo
	ExpireText.BackgroundTransparency = 1.000
	ExpireText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ExpireText.BorderSizePixel = 0
	ExpireText.Position = UDim2.new(0, 55, 0, 25)
	ExpireText.Size = UDim2.new(0, 200, 0, 20)
	ExpireText.ZIndex = 2
	ExpireText.Font = Enum.Font.GothamMedium
	ExpireText.Text = "0/0/0"
	ExpireText.TextColor3 = Compkiller.Colors.SwitchColor
	ExpireText.TextSize = 13.000
	ExpireText.TextTransparency = 0.500
	ExpireText.TextXAlignment = Enum.TextXAlignment.Left

	table.insert(Compkiller.Elements.SwitchColor , {
		Element = ExpireText,
		Property = 'TextColor3'
	});

	TabMainFrame.Name = Compkiller:_RandomString()
	TabMainFrame.Parent = MainFrame
	TabMainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	TabMainFrame.BackgroundTransparency = 1.000
	TabMainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabMainFrame.BorderSizePixel = 0
	TabMainFrame.ClipsDescendants = true
	TabMainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	TabMainFrame.Size = UDim2.new(1, 0, 1, 0)
	TabMainFrame.ZIndex = 5

	if Compkiller:_IsMobile() then
		Compkiller:_AddDragBlacklist(TabButtons);
	end;

	WindowOpen:Connect(function(v)
		if WindowArgs.PerformanceMode then
			MainFrame.BackgroundTransparency = (v and 0) or 1;
			return;	
		end;

		if v then
			Compkiller:_Animation(MainFrame,TweenInfo.new(0.2),{
				Size = Config.Scale
			})

			Compkiller:_Animation(TabButtonScrollingFrame,TweenInfo.new(0.35),{
				Position = UDim2.new(0.5, 0, 0.5, 0)
			})

			Compkiller:_Animation(CompLogo,TweenInfo.new(0.2),{
				ImageTransparency = 0
			})

			Compkiller:_Animation(WindowLabel,TweenInfo.new(0.2),{
				TextTransparency = 0
			})

			Compkiller:_Animation(UserProfile,TweenInfo.new(0.2),{
				ImageTransparency = 0
			})

			Compkiller:_Animation(UserText,TweenInfo.new(0.2),{
				TextTransparency = 0
			})

			Compkiller:_Animation(ExpireText,TweenInfo.new(0.2),{
				TextTransparency = 0.5
			})

			Compkiller:_Animation(MainFrame,TweenInfo.new(0.2),{
				BackgroundTransparency = 0
			})

			Compkiller:_Animation(LineFrame1,TweenInfo.new(0.3),{
				BackgroundTransparency = 0,
				Size = UDim2.new(0, 20, 1, 0)
			})

			Compkiller:_Animation(TabFrame,TweenInfo.new(0.2),{
				BackgroundTransparency = TabFrameBaseTrans
			})
		else
			Compkiller:_Animation(MainFrame,TweenInfo.new(0.2),{
				Size = UDim2.new(math.max(Config.Scale.X.Scale - 0.05,0) , Config.Scale.X.Offset - 10 , math.max(Config.Scale.Y.Scale - 0.05,0) , Config.Scale.Y.Offset - 10)
			})

			Compkiller:_Animation(TabButtonScrollingFrame,TweenInfo.new(0.35),{
				Position = UDim2.new(1.5, 100, 0.5, 0)
			})

			Compkiller:_Animation(LineFrame1,TweenInfo.new(0.1),{
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 1, 1, 0)
			})

			Compkiller:_Animation(CompLogo,TweenInfo.new(0.2),{
				ImageTransparency = 1
			})

			Compkiller:_Animation(WindowLabel,TweenInfo.new(0.2),{
				TextTransparency = 1
			})

			Compkiller:_Animation(UserProfile,TweenInfo.new(0.2),{
				ImageTransparency = 1
			})

			Compkiller:_Animation(UserText,TweenInfo.new(0.2),{
				TextTransparency = 1
			})

			Compkiller:_Animation(ExpireText,TweenInfo.new(0.2),{
				TextTransparency = 1
			})

			Compkiller:_Animation(MainFrame,TweenInfo.new(0.2),{
				BackgroundTransparency = 1
			})

			Compkiller:_Animation(TabFrame,TweenInfo.new(0.1),{
				BackgroundTransparency = 1
			})
		end;
	end);

	TabHover:Connect(function(value)
		local Style = TweenInfo.new(0.45,Enum.EasingStyle.Quint);

		if value then
			Compkiller:_Animation(TabFrame , Style , {
				Size = UDim2.new(0, 185,1, 0)
			});

			WindowLabel.TextXAlignment = Enum.TextXAlignment.Left;
			Compkiller:_Animation(WindowLabel , Style , {
				Position = UDim2.new(0, 115, 0, 45), -- Closer to logo
				Size = UDim2.new(0, 100, 0, 25),
				TextTransparency = 0
			});
			Compkiller:_Animation(CompLogo , Style , {
				Position = UDim2.new(0, 50, 0, 45), -- Original expanded position
				ImageTransparency = 0 
			});

			Compkiller:_Animation(UserText , Style , {
				Position = UDim2.new(0, 55,0, 8),
			});

			Compkiller:_Animation(ExpireText , Style , {
				Position = UDim2.new(0, 55,0, 25),
				TextTransparency = 0.5
			});
		else
			Compkiller:_Animation(TabFrame , Style , {
				Size = UDim2.new(0, 85,1, 0)
			});

			WindowLabel.TextXAlignment = Enum.TextXAlignment.Center;
			Compkiller:_Animation(WindowLabel , Style , {
				Position = UDim2.new(0.5, -12, 0, 45), -- Fine-tuned center
				Size = UDim2.new(1, -10, 0, 25),
				TextTransparency = 1
			});
			Compkiller:_Animation(CompLogo , Style , {
				Position = UDim2.new(0.5, -12, 0, 45), -- Fine-tuned center
				ImageTransparency = 0
			});

			Compkiller:_Animation(UserText , Style , {
				Position = UDim2.new(0, 55 + 25,0, 8),
			});

			Compkiller:_Animation(ExpireText , Style , {
				Position = UDim2.new(0, 55 + 25,0, 25),
				TextTransparency = 1
			});
		end;
	end);

	WindowArgs.UserSettings = {};

	do
		local Signal = Compkiller.__SIGNAL(false);

		local UserSettings = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local SectionFrame = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIListLayout = Instance.new("UIListLayout")
		local Header = Instance.new("Frame")
		local HeaderText = Instance.new("TextLabel")
		local ImageLabel = Instance.new("ImageLabel")

		UserSettings.Name = Compkiller:_RandomString()
		UserSettings.Parent = CompKiller;
		UserSettings.BackgroundColor3 = Compkiller.Colors.BGDBColor;
		UserSettings.BackgroundTransparency = 1
		UserSettings.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserSettings.BorderSizePixel = 0
		UserSettings.Position = UDim2.new(0, 50, 0, 50)
		UserSettings.Size = UDim2.new(0, 235, 0, 300)
		UserSettings.ZIndex = 65;
		UserSettings.Visible = false;

		table.insert(Compkiller.Elements.BGDBColor,{
			Element = UserSettings,
			Property = 'BackgroundColor3'
		});

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = UserSettings

		SectionFrame.Name = Compkiller:_RandomString()
		SectionFrame.Parent = UserSettings
		SectionFrame.BackgroundColor3 = Compkiller.Colors.BGDBColor;
		SectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionFrame.BorderSizePixel = 0
		SectionFrame.Position = UDim2.new(0, 0, 0, 45)
		SectionFrame.Size = UDim2.new(1, 0, 1, -45)
		SectionFrame.ZIndex = 66

		table.insert(Compkiller.Elements.BGDBColor,{
			Element = SectionFrame,
			Property = 'BackgroundColor3'
		});

		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = SectionFrame

		UIListLayout.Parent = SectionFrame
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 5)

		Header.Name = Compkiller:_RandomString()
		Header.Parent = UserSettings
		Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Header.BackgroundTransparency = 1.000
		Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Header.BorderSizePixel = 0
		Header.Size = UDim2.new(1, 0, 0, 45)
		Header.ZIndex = 66

		HeaderText.Name = Compkiller:_RandomString()
		HeaderText.Parent = Header
		HeaderText.AnchorPoint = Vector2.new(0.5, 0.5)
		HeaderText.BackgroundTransparency = 1.000
		HeaderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		HeaderText.BorderSizePixel = 0
		HeaderText.Position = UDim2.new(0.5, 0, 0.5, 0)
		HeaderText.Size = UDim2.new(0, 200, 0, 25)
		HeaderText.ZIndex = 67
		HeaderText.Font = Enum.Font.GothamMedium
		HeaderText.Text = "User Settings"
		HeaderText.TextColor3 = Color3.fromRGB(255, 255, 255)
		HeaderText.TextSize = 15.000

		table.insert(Compkiller.Elements.SwitchColor,{
			Element = HeaderText,
			Property = 'TextColor3'
		});

		ImageLabel.Parent = Header
		ImageLabel.AnchorPoint = Vector2.new(1, 0)
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Position = UDim2.new(1, -5, 0, 5)
		ImageLabel.Size = UDim2.new(0, 15, 0, 15)
		ImageLabel.ZIndex = 67
		ImageLabel.Image = Compkiller:CacheImage("rbxassetid://10747384394")
		ImageLabel.ImageTransparency = 0.500

		function WindowArgs.UserSettings:Create()

			WindowArgs.UserSettings.Root = UserSettings;
			WindowArgs.UserSettings.Signal = Signal;
			WindowArgs.UserSettings.Signal = Compkiller:_Blur(UserSettings,Signal);

			Compkiller:Drag(Header , UserSettings, 0);

			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				local CurrentScale = WindowArgs.MainUIScale.Scale;
				Compkiller:_Animation(UserSettings,TweenInfo.new(0.2),{
					Size = UDim2.new(0, 235, 0, (UIListLayout.AbsoluteContentSize.Y / CurrentScale) + 50)
				})
			end);

			UserSettings:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
				if UserSettings.BackgroundTransparency < 1 then
					UserSettings.Visible = true;
				else
					UserSettings.Visible = false;
				end;
			end);

			function WindowArgs.UserSettings:Window(Value)
				if Value then
					Signal:Fire(true);

					Compkiller:_Animation(UserSettings,TweenInfo.new(0.2),{
						BackgroundTransparency = 0.250,
					});

					Compkiller:_Animation(SectionFrame,TweenInfo.new(0.2),{
						BackgroundTransparency = 0,
					});

					Compkiller:_Animation(HeaderText,TweenInfo.new(0.2),{
						TextTransparency = 0,
					});

					Compkiller:_Animation(ImageLabel,TweenInfo.new(0.2),{
						ImageTransparency = 0.5,
					});
				else
					Signal:Fire(false);

					Compkiller:_Animation(UserSettings,TweenInfo.new(0.2),{
						BackgroundTransparency = 1,
					});

					Compkiller:_Animation(SectionFrame,TweenInfo.new(0.2),{
						BackgroundTransparency = 1,
					});

					Compkiller:_Animation(HeaderText,TweenInfo.new(0.2),{
						TextTransparency = 1,
					});

					Compkiller:_Animation(ImageLabel,TweenInfo.new(0.2),{
						ImageTransparency = 1,
					});
				end;
			end;

			Compkiller:_Input(ImageLabel,function()
				WindowArgs.UserSettings:Window(false);
			end);

			WindowArgs.UserSettings:Window(false);

			return Compkiller:_LoadElement(SectionFrame , true , Signal);
		end;
	end;

	function WindowArgs:SetVisible(bool: boolean)
		CompKiller.Enabled = bool;
	end;

	function WindowArgs:DrawCategory(config : Category)
		config = config or {};
		config.Name = config.Name or "Category";

		local Category = Instance.new("Frame")
		local CategoryText = Instance.new("TextLabel")
		local Frame = Instance.new("Frame")
		local UIGradient = Instance.new("UIGradient")

		Category.Name = Compkiller:_RandomString()
		Category.Parent = TabButtonScrollingFrame
		Category.BackgroundTransparency = 1.000
		Category.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Category.BorderSizePixel = 0
		Category.ClipsDescendants = true
		Category.Size = UDim2.new(1, -10, 0, 22)

		if Compkiller:_IsMobile() then
			Compkiller:_AddDragBlacklist(Category);
		end;

		CategoryText.Name = Compkiller:_RandomString()
		CategoryText.Parent = Category
		CategoryText.BackgroundTransparency = 1.000
		CategoryText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		CategoryText.BorderSizePixel = 0
		CategoryText.Position = UDim2.new(0, 5, 0, 8)
		CategoryText.Size = UDim2.new(1, 200, 0, 10)
		CategoryText.Font = Enum.Font.Gotham
		CategoryText.Text = config.Name
		CategoryText.TextColor3 = Compkiller.Colors.SwitchColor
		CategoryText.TextSize = 16.000
		CategoryText.TextTransparency = 0.500
		CategoryText.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = CategoryText,
			Property = 'TextColor3'
		});

		Frame.Parent = Category
		Frame.AnchorPoint = Vector2.new(0.5, 1)
		Frame.BackgroundColor3 = Compkiller.Colors.Highlight
		Frame.BackgroundTransparency = 0.750
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.5, 0, 1, 0)
		Frame.Size = UDim2.new(1, 0, 0, 1)

		table.insert(Compkiller.Elements.Highlight,{
			Element = Frame,
			Property = "BackgroundColor3"
		});

		UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.05, 0.21), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(0.96, 0.17), NumberSequenceKeypoint.new(1.00, 1.00)}
		UIGradient.Parent = Frame

		local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);

		TabHover:Connect(function(bool)
			if bool then
				Compkiller:_Animation(CategoryText,Tween,{
					TextTransparency = 0.500
				});

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 0.750
				});
			else
				Compkiller:_Animation(CategoryText,Tween,{
					TextTransparency = 1
				});

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 1
				});
			end;
		end);
	end;

	function WindowArgs:DrawContainerTab(TabConfig : ContainerTab)
		TabConfig = Compkiller.__CONFIG(TabConfig,{
			Name = "Tab",
			Icon = "eye",
		});

		local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);
		local TabOpenSignal = Compkiller.__SIGNAL(false);

		local TabArgs = {
			__Current = nil,
			Tabs = {}
		};

		-- Creating Button --

		local TabButton = Instance.new("Frame")
		local Icon = Instance.new("ImageLabel")
		local TabNameLabel = Instance.new("TextLabel")
		local Highlight = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")

		TabButton.Name = Compkiller:_RandomString()
		TabButton.Parent = TabButtonScrollingFrame
		TabButton.BackgroundTransparency = 1.000
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.ClipsDescendants = true
		TabButton.Size = UDim2.new(1, -10, 0, 32)
		TabButton.ZIndex = 3

		if Compkiller:_IsMobile() then
			Compkiller:_AddDragBlacklist(TabButton);
		end;

		Icon.Name = Compkiller:_RandomString()
		Icon.Parent = TabButton
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundColor3 = Compkiller.Colors.Highlight
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 15, 0.5, 0)
		Icon.Size = UDim2.new(0, 15, 0, 15)
		Icon.ZIndex = 3
		Icon.Image = Compkiller:_GetIcon(TabConfig.Icon);
		Icon.ImageColor3 = Compkiller.Colors.Highlight

		table.insert(Compkiller.Elements.Highlight,{
			Element = Icon,
			Property = "ImageColor3"
		});

		TabNameLabel.Name = Compkiller:_RandomString()
		TabNameLabel.Parent = TabButton
		TabNameLabel.AnchorPoint = Vector2.new(0, 0.5)
		TabNameLabel.BackgroundTransparency = 1.000
		TabNameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabNameLabel.BorderSizePixel = 0
		TabNameLabel.Position = UDim2.new(0, 43, 0.5, 0)
		TabNameLabel.Size = UDim2.new(0, 200, 0, 25)
		TabNameLabel.ZIndex = 3
		TabNameLabel.Font = Enum.Font.GothamMedium
		TabNameLabel.Text = TabConfig.Name;
		TabNameLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TabNameLabel.TextSize = 15.000
		TabNameLabel.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TabNameLabel,
			Property = 'TextColor3'
		});

		Highlight.Name = Compkiller:_RandomString()
		Highlight.Parent = TabButton
		Highlight.AnchorPoint = Vector2.new(0.5, 0.5)
		Highlight.BackgroundColor3 = Color3.fromRGB(161, 161, 161)
		Highlight.BackgroundTransparency = 0.925
		Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Highlight.BorderSizePixel = 0
		Highlight.Position = UDim2.new(0.5, 0, 0.5, 0)
		Highlight.Size = UDim2.new(1, -17, 1, 0)
		Highlight.ZIndex = 2

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Highlight

		-- Creating Container --

		local ContainerTab = Instance.new("Frame")
		local MainFrame = Instance.new("Frame")
		local Top = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")

		ContainerTab.Name = Compkiller:_RandomString()
		ContainerTab.Parent = TabMainFrame
		ContainerTab.AnchorPoint = Vector2.new(0.5, 0.5)
		ContainerTab.BackgroundTransparency = 1.000
		ContainerTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContainerTab.BorderSizePixel = 0
		ContainerTab.Position = UDim2.new(0.5, 0, 0.5, 0)
		ContainerTab.Size = UDim2.new(1, -15, 1, -15)
		ContainerTab.ZIndex = 6

		MainFrame.Name = Compkiller:_RandomString()
		MainFrame.Parent = ContainerTab
		MainFrame.AnchorPoint = Vector2.new(0.5, 1)
		MainFrame.BackgroundTransparency = 1.000
		MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MainFrame.BorderSizePixel = 0
		MainFrame.Position = UDim2.new(0.5, 0, 1, -5)
		MainFrame.Size = UDim2.new(1, 0, 1, -35)
		MainFrame.ZIndex = 6
		MainFrame.ClipsDescendants = true

		Top.Name = Compkiller:_RandomString()
		Top.Parent = ContainerTab
		Top.BackgroundTransparency = 1.000
		Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Top.BorderSizePixel = 0
		Top.Size = UDim2.new(1, 0, 0, 25)
		Top.ZIndex = 7

		UIListLayout.Parent = Top
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 10)

		-- Functions --
		Highlight:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
			if Highlight.BackgroundTransparency <= 0.99 then
				ContainerTab.Visible = true;
			else
				ContainerTab.Visible = false;
			end;

			if Compkiller.PerformanceMode then
				if ContainerTab.Visible then
					Compkiller:_SetNilP(ContainerTab , TabMainFrame);
				else
					Compkiller:_SetNilP(ContainerTab , nil);
				end;
			else
				Compkiller:_SetNilP(ContainerTab , TabMainFrame);
			end;
		end);

		local TabOpen = function(bool)
			if bool then
				WindowArgs.SelectedTab = TabButton;

				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0,
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0
				});

				Compkiller:_Animation(Highlight,Tween,{
					BackgroundTransparency = 0.925
				});

				for i,v in next , TabArgs.Tabs do
					if v.Root == TabArgs.__Current.Root then
						v.Remote:Fire(true);
					end;
				end;
			else
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.5
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.5
				});

				Compkiller:_Animation(Highlight,Tween,{
					BackgroundTransparency = 1
				});

				for i,v in next , TabArgs.Tabs do
					v.Remote:Fire(false);
				end;
			end;
		end;

		if not WindowArgs.Tabs[1] then
			TabOpenSignal:Fire(true);
			TabOpen(true);
		else
			TabOpen(false);
		end;

		table.insert(WindowArgs.Tabs , {
			Root = TabButton,
			Remote = TabOpenSignal
		});

		Compkiller:_Hover(TabButton,function()
			if WindowArgs.SelectedTab ~= TabButton then
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.1
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.1
				});
			end;
		end , function()
			if WindowArgs.SelectedTab ~= TabButton then
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.5
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.5
				});
			end;
		end)

		TabOpenSignal:Connect(TabOpen);

		TabHover:Connect(function(bool)
			if bool then
				Compkiller:_Animation(TabButton,Tween,{
					Size = UDim2.new(1, -10, 0, 32)
				});

				Compkiller:_Animation(Icon,Tween,{
					Size = UDim2.new(0, 16, 0, 16),
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					Size = UDim2.new(0, 200, 0, 25),
					Position = UDim2.new(0, 43, 0.5, 0)
				});

				Compkiller:_Animation(UICorner,Tween,{
					CornerRadius = UDim.new(0, 4)
				});

				Compkiller:_Animation(Highlight,Tween,{
					Size = UDim2.new(1, -17, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				});
			else
				Compkiller:_Animation(UICorner,Tween,{
					CornerRadius = UDim.new(0, 10)
				});

				Compkiller:_Animation(TabButton,Tween,{
					Size = UDim2.new(1, -10, 0, 32)
				});

				Compkiller:_Animation(Icon,Tween,{
					Size = UDim2.new(0, 16, 0, 16),
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					Size = UDim2.new(0, 200, 0, 25),
					Position = UDim2.new(0, 80, 0.5, 0)
				});

				Compkiller:_Animation(Highlight,Tween,{
					Size = UDim2.new(1, -10,1, 5),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				});
			end;
		end);

		Compkiller:_Input(TabButton,function()
			for i,v in next, WindowArgs.Tabs do
				if v.Root == TabButton then
					v.Remote:Fire(true);
				else
					v.Remote:Fire(false);
				end;
			end;
		end);

		function TabArgs:DrawTab(TabConfig : TabConfig) -- Internal Tab
			TabConfig = Compkiller.__CONFIG(TabConfig,{
				Name = "Tab",
				Type = "Double",
				EnableScrolling = false,
			});

			local InternalSignal = Compkiller.__SIGNAL(false);
			local Frame = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local Highlight = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")

			Frame.Parent = Top
			Frame.BackgroundColor3 = Compkiller.Colors.BlockColor

			table.insert(Compkiller.Elements.BlockColor , {
				Element = Frame,
				Property = "BackgroundColor3"
			});

			Frame.BackgroundTransparency = 1.000
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.ClipsDescendants = true
			Frame.Size = UDim2.new(0, 75, 0, 26)
			Frame.ZIndex = 10

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Frame

			UIStroke.Transparency = 1.000
			UIStroke.Color = Compkiller.Colors.StrokeColor
			UIStroke.Parent = Frame

			table.insert(Compkiller.Elements.StrokeColor,{
				Element = UIStroke,
				Property = "Color"
			});

			Highlight.Name = Compkiller:_RandomString()
			Highlight.Parent = Frame
			Highlight.AnchorPoint = Vector2.new(1, 0.5)
			Highlight.BackgroundColor3 = Compkiller.Colors.Highlight
			Highlight.BackgroundTransparency = 1.000
			Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Highlight.BorderSizePixel = 0
			Highlight.Position = UDim2.new(0, 3, 0.5, 0)
			Highlight.Size = UDim2.new(0, 5, 0, 10)
			Highlight.ZIndex = 11

			table.insert(Compkiller.Elements.Highlight,{
				Element = Highlight,
				Property = "BackgroundColor3"
			});

			UICorner_2.CornerRadius = UDim.new(1, 0)
			UICorner_2.Parent = Highlight

			TextLabel.Parent = Frame
			TextLabel.AnchorPoint = Vector2.new(0, 0.5)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(0, 10, 0.5, 0)
			TextLabel.Size = UDim2.new(0, 200, 0, 20)
			TextLabel.ZIndex = 12
			TextLabel.Font = Enum.Font.GothamMedium
			TextLabel.Text = TabConfig.Name
			TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
			TextLabel.TextSize = 13.000
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left

			table.insert(Compkiller.Elements.SwitchColor , {
				Element = TextLabel,
				Property = 'TextColor3'
			});

			local UpdateScale = function()
				local scale = TextService:GetTextSize(TextLabel.Text,TextLabel.TextSize,TextLabel.Font,Vector2.new(math.huge,math.huge));

				Frame.Size = UDim2.new(0, scale.X + 19, 0, 26)
			end;

			UpdateScale()

			local ToggleUI = function(bool)

				UpdateScale();

				if bool then

					Compkiller:_Animation(Highlight,TweenInfo.new(0.2),{
						BackgroundTransparency = 0,
						Size = UDim2.new(0, 5, 0, 10)
					})

					Compkiller:_Animation(Frame,TweenInfo.new(0.2),{
						BackgroundTransparency = 0
					})

					Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
						Transparency = 0
					})

					Compkiller:_Animation(TextLabel,TweenInfo.new(0.2),{
						TextTransparency = 0
					})
				else

					Compkiller:_Animation(Highlight,TweenInfo.new(0.2),{
						BackgroundTransparency = 1,
						Size = UDim2.new(0, 5, 0, 2)
					})

					Compkiller:_Animation(Frame,TweenInfo.new(0.2),{
						BackgroundTransparency = 1
					})

					Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
						Transparency = 1
					})

					Compkiller:_Animation(TextLabel,TweenInfo.new(0.2),{
						TextTransparency = 0.5
					})
				end;
			end;


			local Id = {
				Root = Frame,
				Remote = InternalSignal
			};

			InternalSignal:Connect(ToggleUI)


			if not TabArgs.Tabs[1] then
				TabArgs.__Current = Id;

				InternalSignal:Fire(true)
			end;

			table.insert(TabArgs.Tabs,Id)

			Compkiller:_Input(Frame,function()
				for i,v in next , TabArgs.Tabs do
					if v.Root == Frame then
						TabArgs.__Current = v;

						v.Remote:Fire(true);
					else
						v.Remote:Fire(false);
					end;
				end;
			end);

			return WindowArgs:DrawTab(TabConfig , {
				ID = Id,
				Highlight = Highlight,
				Signal = InternalSignal,
				Parent = MainFrame
			});
		end;

		return TabArgs;
	end;

	function WindowArgs:AddUnbind(UilistLayout: UIListLayout , Scrolling)

		local upd = function()
			local CurrentScale = (Compkiller.MainUIScale and Compkiller.MainUIScale.Scale) or 1;
			Scrolling.ScrollingEnabled = true
			UilistLayout.VerticalFlex = Enum.UIFlexAlignment.None;
			Scrolling.CanvasSize = UDim2.fromOffset(0,(UilistLayout.AbsoluteContentSize.Y / CurrentScale) + 5)
		end;

		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(upd);

		return task.defer(function()
			while true do task.wait(1)
				upd();
			end;
		end)

		--[[local Parent: ScrollingFrame = UilistLayout.Parent;

		Parent = Parent or Scrolling;

		local Detection = function()
			local Target = (UilistLayout.AbsoluteContentSize.Y);

			for i,v in next , Parent:GetChildren() do task.wait(0.1)
				local UIList = v:FindFirstChildWhichIsA('UIListLayout');
				if v:IsA('Frame') and UIList then
					if (UIList.AbsoluteContentSize.Y >= Target) or (v.AbsoluteSize.Y >= Target) or (UilistLayout.AbsoluteContentSize.Y > Parent.AbsoluteSize.Y) then
						UilistLayout.VerticalFlex = Enum.UIFlexAlignment.None;
						Parent.ScrollingEnabled = true;
					else
						Parent.ScrollingEnabled = false;
						UilistLayout.VerticalFlex = Enum.UIFlexAlignment.None;
					end;
				end
			end;
		end;

		local Executable = function()
			while true do task.wait(0.15);
				pcall(Detection);
			end;
		end;

		table.insert(WindowArgs.THREADS,task.spawn(Executable))]]
	end;

	function WindowArgs:DrawConfig(Configuration : TabConfigManager , Internal)
		Configuration = Compkiller.__CONFIG(Configuration,{
			Name = "Config",
			Icon = "folder",
			Config = nil
		});

		local TabOpenSignal = Compkiller.__SIGNAL(false);
		local TabArgs = {};

		-- Button --
		local TabButton = Instance.new("Frame")
		local Icon = Instance.new("ImageLabel")
		local TabNameLabel = Instance.new("TextLabel")
		local Highlight = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")

		if Compkiller:_IsMobile() then
			Compkiller:_AddDragBlacklist(TabButton);
		end;

		TabButton.Name = Compkiller:_RandomString()
		TabButton.Parent = TabButtonScrollingFrame
		TabButton.BackgroundTransparency = 1.000
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.ClipsDescendants = true
		TabButton.Size = UDim2.new(1, -10, 0, 32)
		TabButton.ZIndex = 3

		Icon.Name = Compkiller:_RandomString()
		Icon.Parent = TabButton
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundColor3 = Compkiller.Colors.Highlight
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 15, 0.5, 0)
		Icon.Size = UDim2.new(0, 15, 0, 15)
		Icon.ZIndex = 3
		Icon.Image = Compkiller:_GetIcon(Configuration.Icon);
		Icon.ImageColor3 = Compkiller.Colors.Highlight

		table.insert(Compkiller.Elements.Highlight,{
			Element = Icon,
			Property = "ImageColor3"
		});

		TabNameLabel.Name = Compkiller:_RandomString()
		TabNameLabel.Parent = TabButton
		TabNameLabel.AnchorPoint = Vector2.new(0, 0.5)
		TabNameLabel.BackgroundTransparency = 1.000
		TabNameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabNameLabel.BorderSizePixel = 0
		TabNameLabel.Position = UDim2.new(0, 43, 0.5, 0)
		TabNameLabel.Size = UDim2.new(0, 200, 0, 25)
		TabNameLabel.ZIndex = 3
		TabNameLabel.Font = Enum.Font.GothamMedium
		TabNameLabel.Text = Configuration.Name;
		TabNameLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TabNameLabel.TextSize = 15.000
		TabNameLabel.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TabNameLabel,
			Property = 'TextColor3'
		});

		Highlight.Name = Compkiller:_RandomString()
		Highlight.Parent = TabButton
		Highlight.AnchorPoint = Vector2.new(0.5, 0.5)
		Highlight.BackgroundColor3 = Color3.fromRGB(161, 161, 161)
		Highlight.BackgroundTransparency = 0.925
		Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Highlight.BorderSizePixel = 0
		Highlight.Position = UDim2.new(0.5, 0, 0.5, 0)
		Highlight.Size = UDim2.new(1, -17, 1, 0)
		Highlight.ZIndex = 2

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Highlight

		local TabConfig = Instance.new("Frame")
		local ConfigList = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Header = Instance.new("Frame")
		local SectionText = Instance.new("TextLabel")
		local SectionClose = Instance.new("ImageLabel")
		local ScrollingFrame = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		local Space = Instance.new("Frame")
		local AddConfig = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local Header_2 = Instance.new("Frame")
		local SectionText_2 = Instance.new("TextLabel")
		local SectionClose_2 = Instance.new("ImageLabel")
		local Frame = Instance.new("Frame")
		local UIStroke_3 = Instance.new("UIStroke")
		local UICorner_3 = Instance.new("UICorner")
		local TextBox = Instance.new("TextBox")
		local Button = Instance.new("Frame")
		local BlockLine = Instance.new("Frame")
		local Frame_2 = Instance.new("Frame")
		local UIStroke_4 = Instance.new("UIStroke")
		local UICorner_4 = Instance.new("UICorner")
		local TextLabel = Instance.new("TextLabel")

		TabConfig.Name = Compkiller:_RandomString()
		TabConfig.Parent = TabMainFrame
		TabConfig.AnchorPoint = Vector2.new(0.5, 0.5)
		TabConfig.BackgroundTransparency = 1.000
		TabConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabConfig.BorderSizePixel = 0
		TabConfig.Position = UDim2.new(0.5, 0, 0.5, 0)
		TabConfig.Size = UDim2.new(1, 0, 1, 0)
		TabConfig.ZIndex = 6

		ConfigList.Name = Compkiller:_RandomString()
		ConfigList.Parent = TabConfig
		ConfigList.AnchorPoint = Vector2.new(0.5, 0)
		ConfigList.BackgroundColor3 = Compkiller.Colors.BlockColor

		table.insert(Compkiller.Elements.BlockColor , {
			Element = ConfigList,
			Property = "BackgroundColor3"
		});

		ConfigList.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ConfigList.BorderSizePixel = 0
		ConfigList.Position = UDim2.new(0.5, 0, 0, 5)
		ConfigList.Size = UDim2.new(1, -10, 1, -110)
		ConfigList.ZIndex = 9

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = ConfigList

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = ConfigList

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		Header.Name = Compkiller:_RandomString()
		Header.Parent = ConfigList
		Header.BackgroundTransparency = 1.000
		Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Header.BorderSizePixel = 0
		Header.Size = UDim2.new(1, 0, 0, 35)
		Header.ZIndex = 9

		SectionText.Name = Compkiller:_RandomString()
		SectionText.Parent = Header
		SectionText.AnchorPoint = Vector2.new(0, 0.5)
		SectionText.BackgroundTransparency = 1.000
		SectionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionText.BorderSizePixel = 0
		SectionText.Position = UDim2.new(0, 12, 0.5, 0)
		SectionText.Size = UDim2.new(0, 200, 0, 25)
		SectionText.ZIndex = 10
		SectionText.Font = Enum.Font.GothamMedium
		SectionText.Text = "Config List"
		SectionText.TextColor3 = Compkiller.Colors.SwitchColor
		SectionText.TextSize = 14.000
		SectionText.TextTransparency = 0.500
		SectionText.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = SectionText,
			Property = 'TextColor3'
		});

		SectionClose.Name = Compkiller:_RandomString()
		SectionClose.Parent = Header
		SectionClose.AnchorPoint = Vector2.new(1, 0.5)
		SectionClose.BackgroundTransparency = 1.000
		SectionClose.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionClose.BorderSizePixel = 0
		SectionClose.Position = UDim2.new(1, -12, 0.5, 0)
		SectionClose.Size = UDim2.new(0, 17, 0, 17)
		SectionClose.ZIndex = 10
		SectionClose.Image = Compkiller:CacheImage("rbxassetid://109535175596957")
		SectionClose.ImageTransparency = 0.500


		ScrollingFrame.Parent = ConfigList
		ScrollingFrame.Active = true
		ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0)
		ScrollingFrame.BackgroundTransparency = 1.000
		ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ScrollingFrame.BorderSizePixel = 0
		ScrollingFrame.Position = UDim2.new(0.5, 0, 0, 35)
		ScrollingFrame.Size = UDim2.new(1, -10, 1, -45)
		ScrollingFrame.ZIndex = 12
		ScrollingFrame.ScrollBarThickness = 0

		UIListLayout.Parent = ScrollingFrame
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 7)

		Space.Name = Compkiller:_RandomString()
		Space.Parent = ScrollingFrame
		Space.BackgroundTransparency = 1.000
		Space.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Space.BorderSizePixel = 0

		AddConfig.Name = Compkiller:_RandomString()
		AddConfig.Parent = TabConfig
		AddConfig.AnchorPoint = Vector2.new(0.5, 1)
		AddConfig.BackgroundColor3 = Compkiller.Colors.BlockColor

		table.insert(Compkiller.Elements.BlockColor , {
			Element = AddConfig,
			Property = "BackgroundColor3"
		});

		AddConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
		AddConfig.BorderSizePixel = 0
		AddConfig.Position = UDim2.new(0.5, 0, 1, -5)
		AddConfig.Size = UDim2.new(1, -10, 0, 95)
		AddConfig.ZIndex = 9

		UICorner_2.CornerRadius = UDim.new(0, 6)
		UICorner_2.Parent = AddConfig

		UIStroke_2.Color = Compkiller.Colors.StrokeColor
		UIStroke_2.Parent = AddConfig

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke_2,
			Property = "Color"
		});

		Header_2.Name = Compkiller:_RandomString()
		Header_2.Parent = AddConfig
		Header_2.BackgroundTransparency = 1.000
		Header_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Header_2.BorderSizePixel = 0
		Header_2.Size = UDim2.new(1, 0, 0, 35)
		Header_2.ZIndex = 9

		SectionText_2.Name = Compkiller:_RandomString()
		SectionText_2.Parent = Header_2
		SectionText_2.AnchorPoint = Vector2.new(0, 0.5)
		SectionText_2.BackgroundTransparency = 1.000
		SectionText_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionText_2.BorderSizePixel = 0
		SectionText_2.Position = UDim2.new(0, 12, 0.5, 0)
		SectionText_2.Size = UDim2.new(0, 200, 0, 25)
		SectionText_2.ZIndex = 10
		SectionText_2.Font = Enum.Font.GothamMedium
		SectionText_2.Text = "Add Config"
		SectionText_2.TextColor3 = Compkiller.Colors.SwitchColor
		SectionText_2.TextSize = 14.000
		SectionText_2.TextTransparency = 0.500
		SectionText_2.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = SectionText_2,
			Property = 'TextColor3'
		});

		SectionClose_2.Name = Compkiller:_RandomString()
		SectionClose_2.Parent = Header_2
		SectionClose_2.AnchorPoint = Vector2.new(1, 0.5)
		SectionClose_2.BackgroundTransparency = 1.000
		SectionClose_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionClose_2.BorderSizePixel = 0
		SectionClose_2.Position = UDim2.new(1, -12, 0.5, 0)
		SectionClose_2.Size = UDim2.new(0, 17, 0, 17)
		SectionClose_2.ZIndex = 10
		SectionClose_2.Image = Compkiller:CacheImage("rbxassetid://109535175596957")
		SectionClose_2.ImageTransparency = 0.500

		Frame.Parent = AddConfig
		Frame.AnchorPoint = Vector2.new(0.5, 0)
		Frame.BackgroundColor3 = Compkiller.Colors.BlockColor

		table.insert(Compkiller.Elements.BlockColor , {
			Element = Frame,
			Property = "BackgroundColor3"
		});

		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.5, 0, 0, 35)
		Frame.Size = UDim2.new(1, -20, 0, 20)
		Frame.ZIndex = 15

		UIStroke_3.Color = Compkiller.Colors.StrokeColor
		UIStroke_3.Parent = Frame

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke_3,
			Property = "Color"
		});

		UICorner_3.CornerRadius = UDim.new(0, 4)
		UICorner_3.Parent = Frame

		TextBox.Parent = Frame
		TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextBox.Size = UDim2.new(1, -15, 1, -2)
		TextBox.ZIndex = 15
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
		TextBox.PlaceholderText = "Config Name..."
		TextBox.Text = ""
		TextBox.TextColor3 = Compkiller.Colors.SwitchColor
		TextBox.TextSize = 12.000
		TextBox.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TextBox,
			Property = 'TextColor3'
		});

		Button.Name = Compkiller:_RandomString()
		Button.Parent = AddConfig
		Button.AnchorPoint = Vector2.new(0.5, 1)
		Button.BackgroundColor3 = Compkiller.Colors.SwitchColor
		Button.BackgroundTransparency = 1.000
		Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Button.BorderSizePixel = 0
		Button.Position = UDim2.new(0.5, 0, 1, -10)
		Button.Size = UDim2.new(1, -7, 0, 25)
		Button.ZIndex = 10

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = AddConfig
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 0.5, 12)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = 12

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		Frame_2.Parent = Button
		Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame_2.BackgroundColor3 = Compkiller.Colors.Highlight
		Frame_2.BackgroundTransparency = 0.100
		Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame_2.BorderSizePixel = 0
		Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Frame_2.Size = UDim2.new(1, -15, 1, -5)
		Frame_2.ZIndex = 9

		table.insert(Compkiller.Elements.Highlight,{
			Element = Frame_2,
			Property = "BackgroundColor3"
		});

		UIStroke_4.Color = Compkiller.Colors.StrokeColor
		UIStroke_4.Parent = Frame_2

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke_4,
			Property = "Color"
		});

		UICorner_4.CornerRadius = UDim.new(0, 3)
		UICorner_4.Parent = Frame_2

		TextLabel.Parent = Frame_2
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.ZIndex = 10
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = "Add Config"
		TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TextLabel.TextSize = 12.000
		TextLabel.TextStrokeTransparency = 0.900

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TextLabel,
			Property = 'TextColor3'
		});

		local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);

		Highlight:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
			if Highlight.BackgroundTransparency <= 0.99 then
				TabConfig.Visible = true;
			else
				TabConfig.Visible = false;
			end;

			if Compkiller.PerformanceMode then
				if TabConfig.Visible then
					Compkiller:_SetNilP(TabConfig , TabMainFrame);
				else
					Compkiller:_SetNilP(TabConfig , nil);
				end;
			else
				Compkiller:_SetNilP(TabConfig , TabMainFrame);
			end;

		end)

		local TabOpen = function(bool)
			if bool then

				WindowArgs.SelectedTab = TabButton;

				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0,
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0
				});

				Compkiller:_Animation(Highlight,Tween,{
					BackgroundTransparency = 0.925
				});

				--

				Compkiller:_Animation(ConfigList,Tween,{
					BackgroundTransparency = 0,
				});

				Compkiller:_Animation(AddConfig,Tween,{
					BackgroundTransparency = 0,
				});

				Compkiller:_Animation(UIStroke_4,Tween,{
					Transparency = 0,
				});

				Compkiller:_Animation(UIStroke_3,Tween,{
					Transparency = 0,
				});

				Compkiller:_Animation(UIStroke_2,Tween,{
					Transparency = 0,
				});

				Compkiller:_Animation(UIStroke,Tween,{
					Transparency = 0,
				});

				Compkiller:_Animation(SectionText,Tween,{
					TextTransparency = 0.5
				});

				Compkiller:_Animation(TextLabel,Tween,{
					TextTransparency = 0,
					TextStrokeTransparency = 0.9
				});

				Compkiller:_Animation(Frame_2,Tween,{
					BackgroundTransparency = 0.1,
				});

				Compkiller:_Animation(BlockLine,Tween,{
					BackgroundTransparency = 0.5,
				});

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 0,
				});

				Compkiller:_Animation(SectionText_2,Tween,{
					TextTransparency = 0.5
				});

				Compkiller:_Animation(TextBox,Tween,{
					TextTransparency = 0
				});

				Compkiller:_Animation(SectionClose,Tween,{
					ImageTransparency = 0.5,
				});

				Compkiller:_Animation(SectionClose_2,Tween,{
					ImageTransparency = 0.5,
				});
			else

				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.5
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.5
				});

				Compkiller:_Animation(Highlight,Tween,{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(ConfigList,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(AddConfig,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(UIStroke_4,Tween,{
					Transparency = 1,
				});

				Compkiller:_Animation(UIStroke_3,Tween,{
					Transparency = 1,
				});

				Compkiller:_Animation(UIStroke_2,Tween,{
					Transparency = 1,
				});

				Compkiller:_Animation(UIStroke,Tween,{
					Transparency = 1,
				});

				Compkiller:_Animation(SectionText,Tween,{
					TextTransparency = 1
				});

				Compkiller:_Animation(TextLabel,Tween,{
					TextTransparency = 1,
					TextStrokeTransparency = 1
				});

				Compkiller:_Animation(Frame_2,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(BlockLine,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(SectionText_2,Tween,{
					TextTransparency = 1
				});

				Compkiller:_Animation(TextBox,Tween,{
					TextTransparency = 1
				});

				Compkiller:_Animation(SectionClose,Tween,{
					ImageTransparency = 1,
				});

				Compkiller:_Animation(SectionClose_2,Tween,{
					ImageTransparency = 1,
				});
			end;
		end;

		if not WindowArgs.Tabs[1] then
			TabOpenSignal:Fire(true);
			TabOpen(true);
		else
			TabOpen(false);
		end;

		table.insert(WindowArgs.Tabs , {
			Root = TabButton,
			Remote = TabOpenSignal
		});

		Compkiller:_Hover(TabButton,function()
			if WindowArgs.SelectedTab ~= TabButton then
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.1
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.1
				});
			end;
		end , function()
			if WindowArgs.SelectedTab ~= TabButton then
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.5
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.5
				});
			end;
		end)

		TabOpenSignal:Connect(TabOpen);

		TabHover:Connect(function(bool)
			if bool then
				Compkiller:_Animation(TabButton,Tween,{
					Size = UDim2.new(1, -10, 0, 32)
				});

				Compkiller:_Animation(Icon,Tween,{
					Size = UDim2.new(0, 16, 0, 16),
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					Size = UDim2.new(0, 200, 0, 25),
					Position = UDim2.new(0, 43, 0.5, 0)
				});

				Compkiller:_Animation(UICorner,Tween,{
					CornerRadius = UDim.new(0, 4)
				});

				Compkiller:_Animation(Highlight,Tween,{
					Size = UDim2.new(1, -17, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				});
			else
				Compkiller:_Animation(UICorner,Tween,{
					CornerRadius = UDim.new(0, 10)
				});

				Compkiller:_Animation(TabButton,Tween,{
					Size = UDim2.new(1, -10, 0, 32)
				});

				Compkiller:_Animation(Icon,Tween,{
					Size = UDim2.new(0, 16, 0, 16),
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					Size = UDim2.new(0, 200, 0, 25),
					Position = UDim2.new(0, 80, 0.5, 0)
				});

				Compkiller:_Animation(Highlight,Tween,{
					Size = UDim2.new(1, -10,1, 5),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				});
			end;
		end);

		Compkiller:_Input(TabButton,function()
			for i,v in next, WindowArgs.Tabs do
				if v.Root == TabButton then
					v.Remote:Fire(true);
				else
					v.Remote:Fire(false);
				end;
			end;
		end);

		function TabArgs:_DrawConfig()
			local ConfigButton = {};

			local ConfigBlock = Instance.new("Frame")
			local ConfigText = Instance.new("TextLabel")
			local LinkValues = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local SaveButton = Instance.new("Frame")
			local Frame = Instance.new("Frame")
			local UIStroke = Instance.new("UIStroke")
			local UICorner = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")
			local Icon = Instance.new("ImageLabel")
			local LoadButton = Instance.new("Frame")
			local Frame_2 = Instance.new("Frame")
			local UIStroke_2 = Instance.new("UIStroke")
			local UICorner_2 = Instance.new("UICorner")
			local TextLabel_2 = Instance.new("TextLabel")
			local Icon_2 = Instance.new("ImageLabel")
			local UIStroke_3 = Instance.new("UIStroke")
			local UICorner_3 = Instance.new("UICorner")
			local AuthorText = Instance.new("TextLabel")
			local DelButton = Instance.new("ImageButton")
			local UICorner = Instance.new("UICorner")
			local UIGradient = Instance.new("UIGradient")

			DelButton.Name = Compkiller:_RandomString()
			DelButton.Parent = LinkValues
			DelButton.BackgroundTransparency = 1.000
			DelButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DelButton.BorderSizePixel = 0
			DelButton.LayoutOrder = -9999
			DelButton.Size = UDim2.new(0, 35, 0, 15)
			DelButton.ZIndex = 14
			DelButton.Image = Compkiller:CacheImage("rbxassetid://10747362393")
			DelButton.ImageColor3 = Color3.fromRGB(255, 107, 107)
			DelButton.ImageTransparency = 0.500
			DelButton.ScaleType = Enum.ScaleType.Fit

			UICorner.CornerRadius = UDim.new(1, 0)
			UICorner.Parent = DelButton
			ConfigBlock.Name = Compkiller:_RandomString()
			ConfigBlock.Parent = ScrollingFrame
			ConfigBlock.BackgroundColor3 = Color3.fromRGB(33, 34, 40)
			ConfigBlock.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ConfigBlock.BorderSizePixel = 0
			ConfigBlock.BackgroundTransparency = 1
			ConfigBlock.Size = UDim2.new(1, -1, 0, 40)
			ConfigBlock.ZIndex = 10

			if Compkiller:_IsMobile() then
				Compkiller:_AddDragBlacklist(ConfigBlock);
			end;

			ConfigText.Name = Compkiller:_RandomString()
			ConfigText.Parent = ConfigBlock
			ConfigText.AnchorPoint = Vector2.new(0, 0.5)
			ConfigText.BackgroundTransparency = 1.000
			ConfigText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ConfigText.BorderSizePixel = 0
			ConfigText.Position = UDim2.new(0, 12, 0.5, 15)
			ConfigText.Size = UDim2.new(1, -20, 0, 25)
			ConfigText.ZIndex = 10
			ConfigText.Font = Enum.Font.GothamMedium
			ConfigText.RichText = true;
			ConfigText.Text = "Config"
			ConfigText.TextColor3 = Compkiller.Colors.SwitchColor
			ConfigText.TextSize = 13.000
			ConfigText.TextTransparency = 1
			ConfigText.TextXAlignment = Enum.TextXAlignment.Left

			table.insert(Compkiller.Elements.SwitchColor , {
				Element = ConfigText,
				Property = 'TextColor3'
			});

			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.29, 0.00), NumberSequenceKeypoint.new(0.33, 1.00), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient.Parent = ConfigText

			LinkValues.Name = Compkiller:_RandomString()
			LinkValues.Parent = ConfigBlock
			LinkValues.AnchorPoint = Vector2.new(1, 0.540000021)
			LinkValues.BackgroundTransparency = 1.000
			LinkValues.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LinkValues.BorderSizePixel = 0
			LinkValues.Position = UDim2.new(1, -12, 0.5, 15)
			LinkValues.Size = UDim2.new(1, 0, 0, 18)
			LinkValues.ZIndex = 11

			UIListLayout.Parent = LinkValues
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			UIListLayout.Padding = UDim.new(0, -10)

			SaveButton.Name = Compkiller:_RandomString()
			SaveButton.Parent = LinkValues
			SaveButton.BackgroundTransparency = 1.000
			SaveButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SaveButton.BorderSizePixel = 0
			SaveButton.Size = UDim2.new(0, 77, 0, 30)
			SaveButton.ZIndex = 14

			Frame.Parent = SaveButton
			Frame.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame.BackgroundColor3 = Compkiller.Colors.Highlight
			Frame.BackgroundTransparency = 1
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
			Frame.Size = UDim2.new(1, -15, 1, -5)
			Frame.ZIndex = 14

			table.insert(Compkiller.Elements.Highlight,{
				Element = Frame,
				Property = "BackgroundColor3"
			});

			UIStroke.Transparency = 1
			UIStroke.Color = Compkiller.Colors.StrokeColor
			UIStroke.Parent = Frame

			table.insert(Compkiller.Elements.StrokeColor,{
				Element = UIStroke,
				Property = "Color"
			});

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Frame

			TextLabel.Parent = Frame
			TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(0.5, 27, 0.5, 0)
			TextLabel.Size = UDim2.new(1, 0, 1, 0)
			TextLabel.ZIndex = 14
			TextLabel.Font = Enum.Font.GothamMedium
			TextLabel.Text = "Save"
			TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
			TextLabel.TextSize = 12.000
			TextLabel.TextStrokeTransparency = 1
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.TextTransparency = 1

			table.insert(Compkiller.Elements.SwitchColor , {
				Element = TextLabel,
				Property = 'TextColor3'
			});

			Icon.Name = Compkiller:_RandomString()
			Icon.Parent = Frame
			Icon.AnchorPoint = Vector2.new(0, 0.5)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0, 5, 0.5, 0)
			Icon.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
			Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Icon.ZIndex = 15
			Icon.Image = Compkiller:CacheImage("rbxassetid://10734941499")
			Icon.ImageTransparency = 1;

			LoadButton.Name = Compkiller:_RandomString()
			LoadButton.Parent = LinkValues
			LoadButton.BackgroundTransparency = 1.000
			LoadButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LoadButton.BorderSizePixel = 0
			LoadButton.Size = UDim2.new(0, 77, 0, 30)
			LoadButton.ZIndex = 14

			Frame_2.Parent = LoadButton
			Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame_2.BackgroundColor3 = Compkiller.Colors.Highlight
			Frame_2.BackgroundTransparency = 1
			Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame_2.BorderSizePixel = 0
			Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
			Frame_2.Size = UDim2.new(1, -15, 1, -5)
			Frame_2.ZIndex = 14

			table.insert(Compkiller.Elements.Highlight,{
				Element = Frame_2,
				Property = "BackgroundColor3"
			});

			UIStroke_2.Transparency = 1
			UIStroke_2.Color = Compkiller.Colors.StrokeColor
			UIStroke_2.Parent = Frame_2

			table.insert(Compkiller.Elements.StrokeColor,{
				Element = UIStroke_2,
				Property = "Color"
			});

			UICorner_2.CornerRadius = UDim.new(0, 3)
			UICorner_2.Parent = Frame_2

			TextLabel_2.Parent = Frame_2
			TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
			TextLabel_2.BackgroundTransparency = 1.000
			TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_2.BorderSizePixel = 0
			TextLabel_2.Position = UDim2.new(0.5, 27, 0.5, 0)
			TextLabel_2.Size = UDim2.new(1, 0, 1, 0)
			TextLabel_2.ZIndex = 14
			TextLabel_2.Font = Enum.Font.GothamMedium
			TextLabel_2.Text = "Load"
			TextLabel_2.TextColor3 = Compkiller.Colors.SwitchColor
			TextLabel_2.TextSize = 12.000
			TextLabel_2.TextStrokeTransparency = 1
			TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel_2.TextTransparency = 1

			table.insert(Compkiller.Elements.SwitchColor , {
				Element = TextLabel_2,
				Property = 'TextColor3'
			});

			Icon_2.Name = Compkiller:_RandomString()
			Icon_2.Parent = Frame_2
			Icon_2.AnchorPoint = Vector2.new(0, 0.5)
			Icon_2.BackgroundTransparency = 1.000
			Icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon_2.BorderSizePixel = 0
			Icon_2.Position = UDim2.new(0, 5, 0.5, 0)
			Icon_2.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
			Icon_2.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Icon_2.ZIndex = 15
			Icon_2.Image = Compkiller:CacheImage("rbxassetid://10723344270")
			Icon_2.ImageTransparency = 1
			UIStroke_3.Transparency = 1

			UIStroke_3.Color = Compkiller.Colors.StrokeColor
			UIStroke_3.Parent = ConfigBlock

			table.insert(Compkiller.Elements.StrokeColor,{
				Element = UIStroke_3,
				Property = "Color"
			});

			UICorner_3.CornerRadius = UDim.new(0, 6)
			UICorner_3.Parent = ConfigBlock

			AuthorText.Name = Compkiller:_RandomString()
			AuthorText.Parent = ConfigBlock
			AuthorText.AnchorPoint = Vector2.new(0, 0.5)
			AuthorText.BackgroundTransparency = 1.000
			AuthorText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			AuthorText.BorderSizePixel = 0
			AuthorText.Position = UDim2.new(0.5, -65, 0.5, 15)
			AuthorText.Size = UDim2.new(1, -20, 0, 25)
			AuthorText.ZIndex = 10
			AuthorText.Font = Enum.Font.GothamMedium
			AuthorText.RichText = true;
			AuthorText.Text = "Author: <font color=\"rgb(17, 238, 253)\">NoFi</font>"
			AuthorText.TextColor3 = Compkiller.Colors.SwitchColor
			AuthorText.TextSize = 13.000
			AuthorText.TextTransparency = 1
			AuthorText.TextXAlignment = Enum.TextXAlignment.Left

			table.insert(Compkiller.Elements.SwitchColor , {
				Element = TabNameLabel,
				Property = 'TextColor3'
			});

			function ConfigButton:SetInfo(Author , ConfigName)
				local R,G,B = tostring(math.floor(Compkiller.Colors.Highlight.R * 255)) , tostring(math.floor(Compkiller.Colors.Highlight.G * 255)) , tostring(math.floor(Compkiller.Colors.Highlight.B * 255));

				AuthorText.Text = string.format("Author: <font color=\"rgb(%s, %s, %s)\">%s</font>" ,R,G,B , tostring(Author));
				ConfigText.Text = ConfigName;

				if ConfigBlock.BackgroundTransparency >= 0.7 then
					ConfigButton:Update();
				end;
			end;

			function ConfigButton:Toggle(v)
				if v then
					Compkiller:_Animation(ConfigBlock,Tween,{
						BackgroundTransparency = 0
					});

					Compkiller:_Animation(LinkValues,Tween,{
						Position = UDim2.new(1, -12, 0.5, 0)
					});

					Compkiller:_Animation(ConfigText,Tween,{
						TextTransparency = 0.3,
						Position = UDim2.new(0, 12, 0.5, 0)
					});

					Compkiller:_Animation(Frame,Tween,{
						BackgroundTransparency = 0.100
					});

					Compkiller:_Animation(UIStroke,Tween,{
						Transparency = 0
					});

					Compkiller:_Animation(AuthorText,Tween,{
						TextTransparency = 0.5,
						Position = UDim2.new(0,AuthorText:GetAttribute('SPC'), 0.5, 0)
					});

					Compkiller:_Animation(Icon_2,Tween,{
						ImageTransparency = 0
					});

					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0
					});

					Compkiller:_Animation(Frame_2,Tween,{
						BackgroundTransparency = 0.100
					});

					Compkiller:_Animation(UIStroke_2,Tween,{
						Transparency = 0
					});

					Compkiller:_Animation(TextLabel,Tween,{
						TextStrokeTransparency = 0.900,
						TextTransparency = 0
					});

					Compkiller:_Animation(TextLabel_2,Tween,{
						TextStrokeTransparency = 0.900,
						TextTransparency = 0
					});
				else
					Compkiller:_Animation(AuthorText,Tween,{
						TextTransparency = 1,
						Position = UDim2.new(0.5, -65, 0.5, 15)
					});

					Compkiller:_Animation(Icon_2,Tween,{
						ImageTransparency = 1
					});

					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 1
					});

					Compkiller:_Animation(LinkValues,Tween,{
						Position = UDim2.new(1, -12, 0.5, 15)
					});

					Compkiller:_Animation(ConfigBlock,Tween,{
						BackgroundTransparency = 1
					});

					Compkiller:_Animation(ConfigText,Tween,{
						TextTransparency = 1,
						Position = UDim2.new(0, 12, 0.5, 15)
					});

					Compkiller:_Animation(Frame,Tween,{
						BackgroundTransparency = 1
					});

					Compkiller:_Animation(UIStroke,Tween,{
						Transparency = 1
					});

					Compkiller:_Animation(Frame_2,Tween,{
						BackgroundTransparency = 1
					});

					Compkiller:_Animation(UIStroke_2,Tween,{
						Transparency = 1
					});

					Compkiller:_Animation(TextLabel,Tween,{
						TextStrokeTransparency = 1,
						TextTransparency = 1
					});

					Compkiller:_Animation(TextLabel_2,Tween,{
						TextStrokeTransparency = 1,
						TextTransparency = 1
					});
				end;
			end;

			function ConfigButton:Update()
				local nameScale = TextService:GetTextSize(ConfigText.Text,ConfigText.TextSize,ConfigText.Font,Vector2.new(math.huge,math.huge));

				AuthorText:SetAttribute('SPC',math.clamp(nameScale.X + 20 , 100,150));

				AuthorText.Position = UDim2.new(0, AuthorText:GetAttribute('SPC'), 0.5, 15)
			end;

			ConfigButton:Update();

			Compkiller:_Input(LoadButton,function()
				task.spawn(ConfigButton.OnLoad);
			end);

			Compkiller:_Input(SaveButton,function()
				task.spawn(ConfigButton.OnSave);
			end);

			DelButton.MouseButton1Click:Connect(function()
				task.spawn(ConfigButton.OnDelete);
			end)

			ConfigButton.OnLoad = nil;
			ConfigButton.OnSave = nil;
			ConfigButton.OnDelete = nil;

			return ConfigButton;
		end;

		function TabArgs:Init()
			local __signals = {};
			local Init = {};

			Compkiller:_Input(Button,function()
				if TextBox.Text:byte() then
					WindowArgs.Notify.new({
						Title = "Configs",
						Icon = Compkiller:_GetIcon(Config.Logo),
						Content = "Create config \""..TextBox.Text.."\""
					})

					Configuration.Config:WriteConfig({
						Name = TextBox.Text,
						Author = WindowArgs.Username,
					});
				end;
			end);

			local Refresh = function()
				local FullConfig = Configuration.Config:GetFullConfigs();

				for i,v in next, ScrollingFrame:GetChildren() do
					if v:IsA('Frame') and v.Name ~= "Space" then
						v:Destroy();
					end;
				end;

				for i,v in next , __signals do
					v:Disconnect();
				end;

				for i,v in next , FullConfig do
					local Button = TabArgs:_DrawConfig();

					Button:SetInfo(v.Info.Author,v.Name);

					table.insert(__signals,TabOpenSignal:Connect(function(v)
						Button:Toggle(v);
					end));

					Button.OnLoad = function()
						WindowArgs.Notify.new({
							Title = "Configs",
							Icon = Compkiller:CacheImage(Config.Logo),
							Content = "Load config \""..v.Name.."\""
						})

						Configuration.Config:LoadConfig(v.Name);
					end;

					Button.OnSave = function()
						WindowArgs.Notify.new({
							Title = "Configs",
							Icon = Compkiller:CacheImage(Config.Logo),
							Content = "Save config \""..v.Name.."\""
						})

						Button:SetInfo(v.Info.Author,v.Name);

						Configuration.Config:WriteConfig({
							Name = v.Name,
							Author = v.Info.Author;
						});
					end

					Button.OnDelete = function()
						WindowArgs.Notify.new({
							Title = "Configs",
							Icon = Compkiller:CacheImage(Config.Logo),
							Content = "Delete config \""..v.Name.."\""
						})

						Configuration.Config:DeleteConfig(v.Name)
					end
				end;
			end;

			Refresh();

			Init.THREAD = task.spawn(function()
				local OldIndex = Configuration.Config:GetConfigCount();

				while true do task.wait(1);
					local CountInDirectory = Configuration.Config:GetConfigCount();

					if OldIndex ~= CountInDirectory then
						OldIndex = CountInDirectory;

						Refresh();
					end;
				end;
			end);

			return Init;
		end;

		return TabArgs;
	end;

	function WindowArgs:DrawTab(TabConfig : TabConfig , Internal)
		TabConfig = Compkiller.__CONFIG(TabConfig,{
			Name = "Tab",
			Icon = "eye",
			Type = "Double"
		});

		local TabOpenSignal = Compkiller.__SIGNAL(false);
		local TabArgs = {};
		local Upvalue = {};
		local BASE_PADDING = 10;

		if Internal then

			local TabContent = Instance.new("Frame")
			local Left = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Right = Instance.new("ScrollingFrame")
			local UIListLayout_2 = Instance.new("UIListLayout")

			TabContent.Name = Compkiller:_RandomString()
			TabContent.Parent = Internal.Parent;
			TabContent.AnchorPoint = Vector2.new(0.5, 0.5)
			TabContent.BackgroundTransparency = 1.000
			TabContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabContent.BorderSizePixel = 0
			TabContent.Position = UDim2.new(0.5, 0, 0.5, 0)
			TabContent.Size = UDim2.new(1, -5,1, -5)
			TabContent.ZIndex = 6

			Left.Name = Compkiller:_RandomString()
			Left.Parent = TabContent
			Left.Active = true
			Left.AnchorPoint = Vector2.new(0.5, 0.5)
			Left.BackgroundTransparency = 1.000
			Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Left.BorderSizePixel = 0
			Left.ClipsDescendants = false
			Left.Position = UDim2.new(0.25, -3, 0.5, 0)
			Left.Size = UDim2.new(0.5, -3, 1, 0)
			Left.ZIndex = 8
			Left.BottomImage = ""
			Left.ScrollBarThickness = 0
			Left.TopImage = ""
			--Left.AutomaticCanvasSize = Enum.AutomaticSize.Y;
			Left.CanvasSize = UDim2.new(0, 0, 0, 0)

			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				local CurrentScale = WindowArgs.MainUIScale.Scale;
				Left.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y / CurrentScale)
			end)

			UIListLayout.Parent = Left
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalFlex = Enum.UIFlexAlignment.None
			UIListLayout.Padding = UDim.new(0, BASE_PADDING)

			Right.Name = Compkiller:_RandomString()
			Right.Parent = TabContent
			Right.Active = true
			Right.AnchorPoint = Vector2.new(0.5, 0.5)
			Right.BackgroundTransparency = 1.000
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.ClipsDescendants = false
			Right.Position = UDim2.new(0.75, 3, 0.5, 0)
			Right.Size = UDim2.new(0.5, -3, 1, 0)
			Right.ZIndex = 8
			Right.BottomImage = ""
			--Right.AutomaticCanvasSize = Enum.AutomaticSize.Y;
			Right.CanvasSize = UDim2.new(0, 0, 0, 0)
			Right.ScrollBarThickness = 0
			Right.TopImage = ""

			Upvalue.Left = Left;
			Upvalue.Right = Right;
			Upvalue.LeftLayout = UIListLayout;
			Upvalue.RightLayout = UIListLayout_2;

			UIListLayout_2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				local CurrentScale = WindowArgs.MainUIScale.Scale;
				Right.CanvasSize = UDim2.fromOffset(0,UIListLayout_2.AbsoluteContentSize.Y / CurrentScale)
			end)

			UIListLayout_2.Parent = Right
			UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_2.Padding = UDim.new(0, BASE_PADDING)
			UIListLayout_2.VerticalFlex = Enum.UIFlexAlignment.None

			WindowArgs:AddUnbind(UIListLayout_2 , Right);
			WindowArgs:AddUnbind(UIListLayout , Left);

			if TabConfig.Type == "Single" then
				Right.Visible = false;
				Left.Position = UDim2.new(0.5, 0, 0.5, 0)
				Left.Size = UDim2.new(1,0,1,0)
			end;

			local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);

			Internal.Highlight:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
				if Internal.Highlight.BackgroundTransparency <= 0.99 then
					TabContent.Visible = true;
				else
					TabContent.Visible = false;
				end;

				if Compkiller.PerformanceMode then
					if TabContent.Visible then
						Compkiller:_SetNilP(TabContent , Internal.Parent);
					else
						Compkiller:_SetNilP(TabContent , nil);
					end;
				else
					Compkiller:_SetNilP(TabContent , Internal.Parent);
				end;
			end);

			Upvalue.Left = Left;
			Upvalue.Right = Right;

			if Compkiller:_IsMobile() then
				Compkiller:_AddDragBlacklist(Left);
				Compkiller:_AddDragBlacklist(Right);
			end;

			TabOpenSignal = Internal.Signal;

			if not TabOpenSignal:GetValue() then
				TabContent.Visible = false;
			else
				TabContent.Visible = true;
			end;

			if Compkiller.PerformanceMode then
				if TabContent.Visible then
					Compkiller:_SetNilP(TabContent , Internal.Parent);
				else
					Compkiller:_SetNilP(TabContent , nil);
				end;
			else
				Compkiller:_SetNilP(TabContent , Internal.Parent);
			end;
		else
			-- Button --
			local TabButton = Instance.new("Frame")
			local Icon = Instance.new("ImageLabel")
			local TabNameLabel = Instance.new("TextLabel")
			local Highlight = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")

			TabButton.Name = Compkiller:_RandomString()
			TabButton.Parent = TabButtonScrollingFrame
			TabButton.BackgroundTransparency = 1.000
			TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabButton.BorderSizePixel = 0
			TabButton.ClipsDescendants = true
			TabButton.Size = UDim2.new(1, -10, 0, 32)
			TabButton.ZIndex = 3

			Icon.Name = Compkiller:_RandomString()
			Icon.Parent = TabButton
			Icon.AnchorPoint = Vector2.new(0, 0.5)
			Icon.BackgroundColor3 = Compkiller.Colors.Highlight
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0, 15, 0.5, 0)
			Icon.Size = UDim2.new(0, 15, 0, 15)
			Icon.ZIndex = 3
			Icon.Image = Compkiller:_GetIcon(TabConfig.Icon);
			Icon.ImageColor3 = Compkiller.Colors.Highlight

			table.insert(Compkiller.Elements.Highlight,{
				Element = Icon,
				Property = "ImageColor3"
			});

			TabNameLabel.Name = Compkiller:_RandomString()
			TabNameLabel.Parent = TabButton
			TabNameLabel.AnchorPoint = Vector2.new(0, 0.5)
			TabNameLabel.BackgroundTransparency = 1.000
			TabNameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabNameLabel.BorderSizePixel = 0
			TabNameLabel.Position = UDim2.new(0, 43, 0.5, 0)
			TabNameLabel.Size = UDim2.new(0, 200, 0, 25)
			TabNameLabel.ZIndex = 3
			TabNameLabel.Font = Enum.Font.GothamMedium
			TabNameLabel.Text = TabConfig.Name;
			TabNameLabel.TextColor3 = Compkiller.Colors.SwitchColor
			TabNameLabel.TextSize = 15.000
			TabNameLabel.TextXAlignment = Enum.TextXAlignment.Left

			table.insert(Compkiller.Elements.SwitchColor , {
				Element = TabNameLabel,
				Property = 'TextColor3'
			});

			Highlight.Name = Compkiller:_RandomString()
			Highlight.Parent = TabButton
			Highlight.AnchorPoint = Vector2.new(0.5, 0.5)
			Highlight.BackgroundColor3 = Color3.fromRGB(161, 161, 161)
			Highlight.BackgroundTransparency = 0.925
			Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Highlight.BorderSizePixel = 0
			Highlight.Position = UDim2.new(0.5, 0, 0.5, 0)
			Highlight.Size = UDim2.new(1, -17, 1, 0)
			Highlight.ZIndex = 2

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Highlight

			local TabContent = Instance.new("Frame")
			local Left = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Right = Instance.new("ScrollingFrame")
			local UIListLayout_2 = Instance.new("UIListLayout")

			TabContent.Name = Compkiller:_RandomString()
			TabContent.Parent = TabMainFrame;
			TabContent.AnchorPoint = Vector2.new(0.5, 0.5)
			TabContent.BackgroundTransparency = 1.000
			TabContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabContent.BorderSizePixel = 0
			TabContent.Position = UDim2.new(0.5, 0, 0.5, 0)
			TabContent.Size = UDim2.new(1, -15, 1, -15)
			TabContent.ZIndex = 6

			Left.Name = Compkiller:_RandomString()
			Left.Parent = TabContent
			Left.Active = true
			Left.AnchorPoint = Vector2.new(0.5, 0.5)
			Left.BackgroundTransparency = 1.000
			Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Left.BorderSizePixel = 0
			Left.ClipsDescendants = false
			Left.Position = UDim2.new(0.25, -3, 0.5, 0)
			Left.Size = UDim2.new(0.5, -3, 1, 0)
			Left.ZIndex = 8
			Left.BottomImage = ""
			Left.ScrollBarThickness = 0
			Left.TopImage = ""
			--Left.AutomaticCanvasSize = Enum.AutomaticSize.Y;
			Left.CanvasSize = UDim2.new(0, 0, 0, 0)


			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				local CurrentScale = WindowArgs.MainUIScale.Scale;
				Left.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y / CurrentScale)
			end);

			UIListLayout.Parent = Left
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalFlex = Enum.UIFlexAlignment.None
			UIListLayout.Padding = UDim.new(0, BASE_PADDING)

			Right.Name = Compkiller:_RandomString()
			Right.Parent = TabContent
			Right.Active = true
			Right.AnchorPoint = Vector2.new(0.5, 0.5)
			Right.BackgroundTransparency = 1.000
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.ClipsDescendants = false
			Right.Position = UDim2.new(0.75, 3, 0.5, 0)
			Right.Size = UDim2.new(0.5, -3, 1, 0)
			Right.ZIndex = 8
			Right.BottomImage = ""
			Right.ScrollBarThickness = 0
			Right.TopImage = ""
			--Right.AutomaticCanvasSize = Enum.AutomaticSize.Y;
			Right.CanvasSize = UDim2.new(0, 0, 0, 0)

			Upvalue.Left = Left;
			Upvalue.Right = Right;
			Upvalue.LeftLayout = UIListLayout;
			Upvalue.RightLayout = UIListLayout_2;

			UIListLayout_2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				local CurrentScale = WindowArgs.MainUIScale.Scale;
				Right.CanvasSize = UDim2.fromOffset(0,UIListLayout_2.AbsoluteContentSize.Y / CurrentScale)
			end)

			UIListLayout_2.Parent = Right
			UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_2.Padding = UDim.new(0, BASE_PADDING)
			UIListLayout_2.VerticalFlex = Enum.UIFlexAlignment.None

			WindowArgs:AddUnbind(UIListLayout_2 , Right);
			WindowArgs:AddUnbind(UIListLayout , Left);

			if Compkiller:_IsMobile() then
				Compkiller:_AddDragBlacklist(Left);
				Compkiller:_AddDragBlacklist(Right);
			end;

			if TabConfig.Type == "Single" then
				Right.Visible = false;
				Left.Position = UDim2.new(0.5, 0, 0.5, 0)
				Left.Size = UDim2.new(1, -1, 1, -1)
			end;

			local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);

			Highlight:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
				if Highlight.BackgroundTransparency <= 0.99 then
					TabContent.Visible = true;
				else
					TabContent.Visible = false;
				end;

				if Compkiller.PerformanceMode then
					if TabContent.Visible then
						Compkiller:_SetNilP(TabContent , TabMainFrame);
					else
						Compkiller:_SetNilP(TabContent , nil);
					end;
				else
					Compkiller:_SetNilP(TabContent , TabMainFrame);
				end;
			end)

			local TabOpen = function(bool)
				if bool then

					WindowArgs.SelectedTab = TabButton;

					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0,
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						TextTransparency = 0
					});

					Compkiller:_Animation(Highlight,Tween,{
						BackgroundTransparency = 0.925
					});
				else
					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0.5
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						TextTransparency = 0.5
					});

					Compkiller:_Animation(Highlight,Tween,{
						BackgroundTransparency = 1
					});
				end;
			end;

			if not WindowArgs.Tabs[1] then
				TabOpenSignal:Fire(true);
				TabOpen(true);
			else
				TabOpen(false);
			end;

			table.insert(WindowArgs.Tabs , {
				Root = TabButton,
				Remote = TabOpenSignal
			});

			Compkiller:_Hover(TabButton,function()
				if WindowArgs.SelectedTab ~= TabButton then
					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0.1
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						TextTransparency = 0.1
					});
				end;
			end , function()
				if WindowArgs.SelectedTab ~= TabButton then
					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0.5
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						TextTransparency = 0.5
					});
				end;
			end)

			TabOpenSignal:Connect(TabOpen);

			TabHover:Connect(function(bool)
				if bool then
					Compkiller:_Animation(TabButton,Tween,{
						Size = UDim2.new(1, -10, 0, 32)
					});

					Compkiller:_Animation(Icon,Tween,{
						Size = UDim2.new(0, 16, 0, 16),
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						Size = UDim2.new(0, 200, 0, 25),
						Position = UDim2.new(0, 43, 0.5, 0)
					});

					Compkiller:_Animation(UICorner,Tween,{
						CornerRadius = UDim.new(0, 4)
					});

					Compkiller:_Animation(Highlight,Tween,{
						Size = UDim2.new(1, -17, 1, 0),
						Position = UDim2.new(0.5, 0, 0.5, 0)
					});
				else
					Compkiller:_Animation(UICorner,Tween,{
						CornerRadius = UDim.new(0, 10)
					});

					Compkiller:_Animation(TabButton,Tween,{
						Size = UDim2.new(1, -10, 0, 32)
					});

					Compkiller:_Animation(Icon,Tween,{
						Size = UDim2.new(0, 16, 0, 16),
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						Size = UDim2.new(0, 200, 0, 25),
						Position = UDim2.new(0, 80, 0.5, 0)
					});

					Compkiller:_Animation(Highlight,Tween,{
						Size = UDim2.new(1, -10,1, 5),
						Position = UDim2.new(0.5, 0, 0.5, 0)
					});
				end;
			end);

			Compkiller:_Input(TabButton,function()
				for i,v in next, WindowArgs.Tabs do
					if v.Root == TabButton then
						v.Remote:Fire(true);
					else
						v.Remote:Fire(false);
					end;
				end;
			end);
		end;

		function TabArgs:_UpdateScrolling(Frame: ScrollingFrame , ListLayout: UIListLayout)
			local frame;

			local last = 0;
			local scale = 0;

			local Offset = ListLayout.Padding.Offset;
			local Childrens = Frame:GetChildren();

			local CurrentScale = WindowArgs.MainUIScale.Scale;
			for i,v in next ,Childrens do
				if v:IsA('Frame') then
					if v.LayoutOrder > last then
						scale += (v.AbsoluteSize.Y / CurrentScale) + Offset;

						last = v.LayoutOrder;
						frame = v;
					end;
				end;
			end;

			if frame then
				local originalScale = frame:GetAttribute('OriginalScale');

				if originalScale then
					local CurrentScale = WindowArgs.MainUIScale.Scale;
					local Maximum = Frame.AbsoluteSize.Y / CurrentScale;

					local remainingHeight = Maximum - ((scale) - (frame.AbsoluteSize.Y / CurrentScale));

					if originalScale >= (Frame.AbsoluteSize.Y / CurrentScale) then
						Frame:SetAttribute('LayoutStacks',originalScale + 5);
					else
						Frame:SetAttribute('LayoutStacks',((remainingHeight) + 5));
					end

					local caller = WindowArgs.THREADS[frame];

					if caller then
						caller(true);
					end;
				end;
			end;
		end;

		TabArgs.SectionInfo = {};

		TabArgs.SectionClose = {
			[Upvalue.Left] = {},
			[Upvalue.Right] = {},
		};

		TabArgs.LeftThread = coroutine.wrap(function()
			task.wait();

			while true do RunService.RenderStepped:Wait()
				TabArgs:_UpdateScrolling(Upvalue.Left , Upvalue.LeftLayout);
			end;
		end);

		TabArgs.RightThread = coroutine.wrap(function()
			task.wait(0.1);

			while true do RunService.RenderStepped:Wait()
				TabArgs:_UpdateScrolling(Upvalue.Right , Upvalue.RightLayout);
			end;
		end);

		--TabArgs.LeftThread();
		--TabArgs.RightThread();

		function TabArgs:DrawSection(config: Section)
			config = Compkiller.__CONFIG(config,{
				Name = "Section",
				Position = "left"
			});

			local Parent = (TabConfig.Type == "Double" and ((string.lower(config.Position) == "left" and Upvalue.Left) or Upvalue.Right)) or Upvalue.Left;
			local ParentLayout = (TabConfig.Type == "Double" and ((string.lower(config.Position) == "left" and Upvalue.LeftLayout) or Upvalue.RightLayout)) or Upvalue.LeftLayout;

			local IsOpen = true;

			local Section = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local UIListLayout = Instance.new("UIListLayout")
			local Header = Instance.new("Frame")
			local SectionText = Instance.new("TextLabel")
			local SectionClose = Instance.new("ImageLabel")

			Section.Name = Compkiller:_RandomString()
			Section.Parent = Parent;

			if TabConfig.Type == "Single" then
				Section.Parent = Upvalue.Left;
			end;

			Section.BackgroundColor3 = Compkiller.Colors.BlockColor

			table.insert(Compkiller.Elements.BlockColor , {
				Element = Section,
				Property = "BackgroundColor3"
			});

			if Compkiller:_IsMobile() then
				Compkiller:_AddDragBlacklist(Section);
			end;

			Section.LayoutOrder = #Parent:GetChildren() + 3;
			Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Section.BorderSizePixel = 0
			Section.Size = UDim2.new(1, 0, 0, 0)
			Section.ZIndex = 9
			Section.ClipsDescendants = true;

			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = Section

			UIStroke.Color = Compkiller.Colors.StrokeColor
			UIStroke.Parent = Section

			table.insert(Compkiller.Elements.StrokeColor,{
				Element = UIStroke,
				Property = "Color"
			});

			UIListLayout.Parent = Section
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 5)

			Header.Name = Compkiller:_RandomString()
			Header.Parent = Section
			Header.BackgroundTransparency = 1.000
			Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Header.BorderSizePixel = 0
			Header.LayoutOrder = -100
			Header.Size = UDim2.new(1, 0, 0, 35)
			Header.ZIndex = 9

			SectionText.Name = Compkiller:_RandomString()
			SectionText.Parent = Header
			SectionText.AnchorPoint = Vector2.new(0, 0.5)
			SectionText.BackgroundTransparency = 1.000
			SectionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionText.BorderSizePixel = 0
			SectionText.Position = UDim2.new(0, 12, 0.5, 0)
			SectionText.Size = UDim2.new(0, 200, 0, 25)
			SectionText.ZIndex = 10
			SectionText.Font = Enum.Font.GothamMedium
			SectionText.Text = config.Name;
			SectionText.TextColor3 = Compkiller.Colors.SwitchColor
			SectionText.TextSize = 14.000
			SectionText.TextTransparency = 0.500
			SectionText.TextXAlignment = Enum.TextXAlignment.Left

			table.insert(Compkiller.Elements.SwitchColor , {
				Element = SectionText,
				Property = 'TextColor3'
			});

			SectionClose.Name = Compkiller:_RandomString()
			SectionClose.Parent = Header
			SectionClose.AnchorPoint = Vector2.new(1, 0.5)
			SectionClose.BackgroundTransparency = 1.000
			SectionClose.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionClose.BorderSizePixel = 0
			SectionClose.Position = UDim2.new(1, -12, 0.5, 0)
			SectionClose.Size = UDim2.new(0, 17, 0, 17)
			SectionClose.ZIndex = 10
			SectionClose.Image = Compkiller:CacheImage("rbxassetid://109535175596957")
			SectionClose.ImageTransparency = 0.500

			if not SectionText.Text:byte() then
				Header.Visible = false;
			else
				Header.Visible = true;
			end;

			TabArgs.SectionInfo[Section] = {
				UIListLayout = UIListLayout,
			};

			local refresh = function(Upvalue)
				if not SectionText.Text:byte() then
					Header.Visible = false;
				else
					Header.Visible = true;
				end;

				local CurrentScale = WindowArgs.MainUIScale.Scale;
				Section:SetAttribute('OriginalScale',UIListLayout.AbsoluteContentSize.Y / CurrentScale);

				if IsOpen then
					local FullScale = (Section.AbsolutePosition.Y / CurrentScale) + (UIListLayout.AbsoluteContentSize.Y / CurrentScale);
					local RefPos = (Parent.AbsolutePosition.Y / CurrentScale) + (Parent.AbsoluteSize.Y / CurrentScale);

					if (Section:GetAttribute('Height') and not Compkiller:_IsMobile() and FullScale <= RefPos) then
						Compkiller:_Animation(Section,TweenInfo.new(0.4,Enum.EasingStyle.Quint),{
							Size = UDim2.new(1, 0, 0, math.abs(Section:GetAttribute('Height')) + 5)
						});
					else
						Compkiller:_Animation(Section,TweenInfo.new(0.4,Enum.EasingStyle.Quint),{
							Size = UDim2.new(1, 0, 0, (math.abs(UIListLayout.AbsoluteContentSize.Y) / CurrentScale) - 1)
						});

						if Section:GetAttribute('Lasth') and (UIListLayout.AbsoluteContentSize.Y / CurrentScale) > Section:GetAttribute('Lasth') then
							Section:SetAttribute('Lasth',(math.abs(UIListLayout.AbsoluteContentSize.Y) / CurrentScale) - 1);
						end;
					end;

					TabArgs.SectionClose[Parent][Section] = nil;
				else
					TabArgs.SectionClose[Parent][Section] = Section;

					Compkiller:_Animation(Section,TweenInfo.new(0.4,Enum.EasingStyle.Quint),{
						Size = UDim2.new(1, 0, 0, 35)
					});
				end;
			end;

			WindowArgs.THREADS[Section] = refresh;

			local refreshScale = function()
				local Childrens = Parent:GetChildren();
				local Latest = 0;
				local frameFound = 0;
				local allscale = 0;

				for i,v: Frame in next , Childrens do
					if v:IsA('Frame') then
						if v ~= Section then
							frameFound += 1;
							local CurrentScale = WindowArgs.MainUIScale.Scale;
							allscale += v:GetAttribute('HEIGHTSCALE') or (v.AbsoluteSize.Y / CurrentScale);

							if v.LayoutOrder < Section.LayoutOrder then
								if WindowArgs.THREADS[v] then
									v:SetAttribute('Height',nil);
									WindowArgs.THREADS[v]();
								end;

								Latest += 1;
							end;
						end;
					end;
				end;

				if frameFound == 0 then
					Latest = math.huge;
				end;

				if Latest >= frameFound then
					local lscale = 25;

					local CurrentScale = WindowArgs.MainUIScale.Scale;
					if allscale >= ((Parent.AbsoluteSize.Y / CurrentScale) - lscale) or (UIListLayout.AbsoluteContentSize.Y / CurrentScale) >= ((Parent.AbsoluteSize.Y / CurrentScale) - lscale) then
						Section:SetAttribute('Height',nil);
					else
						local CurrentScale = WindowArgs.MainUIScale.Scale;
						local parentScale = 0;

						for i,v in next , Parent:GetChildren() do
							if v:IsA('Frame') then
								parentScale += v:GetAttribute('HEIGHTSCALE') + ParentLayout.Padding.Offset;
							end;
						end;

						local remainingHeight = (UIListLayout.AbsoluteContentSize.Y / CurrentScale) + ((Parent.AbsoluteSize.Y / CurrentScale) - (parentScale));

						if Section:GetAttribute('Lasth') then
							remainingHeight = math.max(remainingHeight , Section:GetAttribute('Lasth'));
						end;

						Section:SetAttribute('Height',remainingHeight);
						Section:SetAttribute('Lasth',remainingHeight);
					end;
				else
					Section:SetAttribute('Height',nil);
				end;

				refresh();
			end;

			Section.ChildAdded:Connect(function()
				refreshScale();
			end)

			local CurrentScale = WindowArgs.MainUIScale.Scale;
			Section:SetAttribute('HEIGHTSCALE',UIListLayout.AbsoluteContentSize.Y / CurrentScale);

			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				local CurrentScale = WindowArgs.MainUIScale.Scale;
				Section:SetAttribute('HEIGHTSCALE',math.max(UIListLayout.AbsoluteContentSize.Y / CurrentScale , Section:GetAttribute('HEIGHTSCALE') or 0));

				refresh()
			end);

			TabOpenSignal:Connect(function(bool)
				if bool then
					Compkiller:_Animation(Section,TweenInfo.new(0.21),{
						BackgroundTransparency = 0
					})

					Compkiller:_Animation(SectionText,TweenInfo.new(0.21),{
						TextTransparency = 0.500
					})

					Compkiller:_Animation(SectionClose,TweenInfo.new(0.21),{
						ImageTransparency = 0.500
					})
				else
					Compkiller:_Animation(Section,TweenInfo.new(0.21),{
						BackgroundTransparency = 1
					})

					Compkiller:_Animation(SectionText,TweenInfo.new(0.21),{
						TextTransparency = 1
					})

					Compkiller:_Animation(SectionClose,TweenInfo.new(0.21),{
						ImageTransparency = 1
					})
				end;
			end);

			Compkiller:_Input(Header,function()
				IsOpen = not IsOpen;

				if IsOpen then
					Compkiller:_Animation(SectionClose,TweenInfo.new(0.35),{
						Rotation = 0
					});
				else
					Compkiller:_Animation(SectionClose,TweenInfo.new(0.35),{
						Rotation = -180
					});
				end;

				refresh();
				refreshScale();
			end);

			task.delay(2.5,function()
				refresh();
				refreshScale();
			end);

			Header.MouseEnter:Connect(function()
				Compkiller:_Animation(SectionText,TweenInfo.new(0.2),{
					TextTransparency = 0.25
				})
			end)	

			Header.MouseLeave:Connect(function()
				Compkiller:_Animation(SectionText,TweenInfo.new(0.2),{
					TextTransparency = 0.500
				})
			end)

			return Compkiller:_LoadElement(Section , true , TabOpenSignal)
		end;

		return TabArgs;
	end;

	do
		local CloseWindow = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local ImageLabel = Instance.new("ImageLabel")

		CloseWindow.Name = Compkiller:_RandomString()
		CloseWindow.Parent = CompKiller
		CloseWindow.AnchorPoint = Vector2.new(1, 0)
		CloseWindow.BackgroundColor3 = Compkiller.Colors.BGDBColor

		table.insert(Compkiller.Elements.BGDBColor,{
			Element = CloseWindow,
			Property = 'BackgroundColor3'
		});

		CloseWindow.BackgroundTransparency = 1
		CloseWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
		CloseWindow.BorderSizePixel = 0
		CloseWindow.Position = UDim2.new(1, -10, 0, 10)
		CloseWindow.Size = UDim2.new(0, 0, 0, 23)
		CloseWindow.ZIndex = 150
		CloseWindow.ClipsDescendants = true;

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = CloseWindow

		ImageLabel.Parent = CloseWindow
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
		ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeYY
		ImageLabel.ZIndex = 151
		ImageLabel.Image = Config.Logo
		ImageLabel.ImageTransparency = 1
		ImageLabel.ClipsDescendants = false;

		local ToggleCloseUI = function(v)
			ImageLabel.Image = Config.Logo;

			if v then
				ImageLabel.ClipsDescendants = true;

				Compkiller:_Animation(CloseWindow,TweenInfo.new(0.2),{
					Size = UDim2.new(0, 45, 0, 23),
					BackgroundTransparency = 0.025
				})

				Compkiller:_Animation(ImageLabel,TweenInfo.new(0.2),{
					ImageTransparency = (ImageLabel:GetAttribute('Hover') and 0.1) or 0.35
				})
			else
				ImageLabel.ClipsDescendants = false;

				Compkiller:_Animation(CloseWindow,TweenInfo.new(0.2),{
					Size = UDim2.new(0, 0, 0, 23),
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(ImageLabel,TweenInfo.new(0.2),{
					ImageTransparency = 1
				})
			end;
		end;

		function WindowArgs:Watermark()
			local Signal = Compkiller.__SIGNAL(true);

			local Watermark = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Logo = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local Frame = Instance.new("Frame")
			local CompLogo = Instance.new("ImageLabel")
			local WaternarkList = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")

			Watermark.Name = Compkiller:_RandomString()
			Watermark.Parent = CompKiller
			Watermark.AnchorPoint = Vector2.new(1, 0)
			Watermark.BackgroundColor3 = Compkiller.Colors.BGDBColor

			Compkiller:Drag(Watermark , Watermark, 0);

			table.insert(Compkiller.Elements.BGDBColor,{
				Element = Watermark,
				Property = 'BackgroundColor3'
			});

			Watermark.BackgroundTransparency = 0.025
			Watermark.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Watermark.BorderSizePixel = 0
			Watermark.Position = UDim2.new(1, -10, 0, 10)
			Watermark.Size = UDim2.new(0, 45, 0, 23)
			Watermark.ZIndex = 150

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Watermark

			Logo.Name = Compkiller:_RandomString()
			Logo.Parent = Watermark
			Logo.AnchorPoint = Vector2.new(1, 0.5)
			Logo.BackgroundColor3 = Compkiller.Colors.BGDBColor

			table.insert(Compkiller.Elements.BGDBColor,{
				Element = Logo,
				Property = "BackgroundColor3"
			});

			Logo.BackgroundTransparency = 0.300
			Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Logo.BorderSizePixel = 0
			Logo.Position = UDim2.new(0, 5, 0.5, 0)
			Logo.Size = UDim2.new(1, 10, 1, 0)
			Logo.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Logo.ZIndex = 149

			UICorner_2.CornerRadius = UDim.new(0, 3)
			UICorner_2.Parent = Logo

			Frame.Parent = Logo
			Frame.AnchorPoint = Vector2.new(0, 0.5)
			Frame.BackgroundColor3 = Compkiller.Colors.Highlight
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(1, -5, 0.5, 0)
			Frame.Size = UDim2.new(0, 2, 1, 0)
			Frame.ZIndex = 151

			table.insert(Compkiller.Elements.Highlight,{
				Element = Frame,
				Property = "BackgroundColor3"
			});

			CompLogo.Name = Compkiller:_RandomString()
			CompLogo.Parent = Logo
			CompLogo.AnchorPoint = Vector2.new(0.5, 0.5)
			CompLogo.BackgroundTransparency = 1.000
			CompLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
			CompLogo.BorderSizePixel = 0
			CompLogo.Position = UDim2.new(0.5, -2, 0.5, 0)
			CompLogo.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
			CompLogo.SizeConstraint = Enum.SizeConstraint.RelativeYY
			CompLogo.ZIndex = 159
			CompLogo.Image = Config.Logo
			CompLogo.ScaleType = Enum.ScaleType.Fit
			
			if Compkiller.CustomHighlightMode then
				CompLogo.ImageColor3 = Compkiller.Colors.Highlight;

				table.insert(Compkiller.Elements.Highlight , {
					Element = CompLogo,
					Property = 'ImageColor3'
				});
			end;

			WaternarkList.Name = Compkiller:_RandomString()
			WaternarkList.Parent = Watermark
			WaternarkList.AnchorPoint = Vector2.new(0.5, 0)
			WaternarkList.BackgroundTransparency = 1.000
			WaternarkList.BorderColor3 = Color3.fromRGB(0, 0, 0)
			WaternarkList.BorderSizePixel = 0
			WaternarkList.Position = UDim2.new(0.5, 0, 0, 0)
			WaternarkList.Size = UDim2.new(1, -10, 1, 0)
			WaternarkList.ZIndex = 155
			WaternarkList.ClipsDescendants = true

			UIListLayout.Parent = WaternarkList
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			UIListLayout.Padding = UDim.new(0, 3)

			local BackFrame = Instance.new("Frame")

			BackFrame.Name = Compkiller:_RandomString()
			BackFrame.Parent = Watermark
			BackFrame.AnchorPoint = Vector2.new(1, 0.5)
			BackFrame.BackgroundTransparency = 1.000
			BackFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BackFrame.BorderSizePixel = 0
			BackFrame.Position = UDim2.new(1, 0, 0.5, 0)
			BackFrame.Size = UDim2.new(1, 30, 1, 0)

			Compkiller:_Blur(BackFrame,Signal);

			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				local CurrentScale = WindowArgs.MainUIScale.Scale;
				Compkiller:_Animation(Watermark,TweenInfo.new(0.4),{
					Size = UDim2.new(0, (UIListLayout.AbsoluteContentSize.X / CurrentScale) + 8, 0, 23)
				});
			end)

			local Args = {};

			function Args:AddText(Watermark : Watermark)
				Watermark = Compkiller.__CONFIG(Watermark, {
					Text = "Watermark",
					Icon = "info"
				});

				local Icon = Instance.new("ImageLabel")
				local TextLabel = Instance.new("TextLabel")

				Icon.Name = Compkiller:_RandomString()
				Icon.Parent = WaternarkList
				Icon.BackgroundTransparency = 1.000
				Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon.BorderSizePixel = 0
				Icon.Size = UDim2.fromOffset(15,15)
				Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
				Icon.ZIndex = 156
				Icon.Image = Compkiller:_GetIcon(Watermark.Icon);

				TextLabel.Parent = WaternarkList
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Size = UDim2.new(0, 50, 0.699999988, 0)
				TextLabel.ZIndex = 156
				TextLabel.Font = Enum.Font.GothamMedium
				TextLabel.Text = Watermark.Text
				TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
				TextLabel.TextSize = 10.000
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left

				table.insert(Compkiller.Elements.SwitchColor , {
					Element = TextLabel,
					Property = 'TextColor3'
				});

				local Update = function()
					local scale = TextService:GetTextSize(TextLabel.Text,TextLabel.TextSize,TextLabel.Font,Vector2.new(math.huge,math.huge));

					TextLabel.Size = UDim2.new(0, scale.X + 2, 0.7, 0)
				end;

				Update()

				local Arg = {};

				function Arg:SetText(text)
					TextLabel.Text = text;
					Update();
				end;

				function Arg:Visible(v)
					Icon.Visible = v;
					TextLabel.Visible = v;

					if Compkiller.PerformanceMode then
						if v then
							Compkiller:_SetNilP(Icon , WaternarkList);
							Compkiller:_SetNilP(TextLabel , WaternarkList);
						else
							Compkiller:_SetNilP(Icon , nil);
							Compkiller:_SetNilP(TextLabel , nil);
						end;
					else
						Compkiller:_SetNilP(Icon , WaternarkList);
						Compkiller:_SetNilP(TextLabel , WaternarkList);
					end;
				end;

				return Arg;
			end;

			return Args;
		end;

		function WindowArgs:Toggle(Value: boolean)
			if WindowArgs.PerformanceMode then
				MainFrame.Visible = Value;
			end;

			WindowOpen:Fire(Value);

			if Value then
				for i,v in next , WindowArgs.Tabs do
					if v.Root == WindowArgs.SelectedTab then
						v.Remote:Fire(true);
					end;
				end;
			else
				for i,v in next , WindowArgs.Tabs do
					v.Remote:Fire(false);
				end;
			end;
		end;

		function WindowArgs:_ToggleUI()
			WindowArgs.IsOpen = not WindowArgs.IsOpen;

			WindowArgs:Toggle(WindowArgs.IsOpen)
		end;

		local Button = Compkiller:_Input(CloseWindow,function()
			WindowArgs:_ToggleUI()
		end)

		if not Compkiller:_IsMobile() then

			Compkiller:_Hover(Button,function()
				ImageLabel:SetAttribute("Hover",true);
			end , function()
				ImageLabel:SetAttribute("Hover",false);
			end);
		end;

		table.insert(WindowArgs.THREADS,task.spawn(function()
			while true do task.wait(0.5)
				if Compkiller:_IsMobile() then
					ToggleCloseUI(true);

					if WindowArgs.IsOpen then
						Compkiller:_Animation(ImageLabel,TweenInfo.new(0.2),{
							ImageTransparency = 0.35
						});

						ImageLabel:GetAttribute("Hover",false);
					else
						ImageLabel:GetAttribute("Hover",true);

						Compkiller:_Animation(ImageLabel,TweenInfo.new(0.2),{
							ImageTransparency = 0.1
						});
					end;
				else
					if not WindowArgs.IsOpen then
						ToggleCloseUI(true);
					else
						ToggleCloseUI(false);
					end
				end;
			end
		end));

		UserInputService.InputBegan:Connect(function(Input,Typing)
			if not Typing and (Input.KeyCode == Config.Keybind or Input.KeyCode.Name == Config.Keybind) then
				WindowArgs:_ToggleUI()
			end;
		end);
	end;

	function WindowArgs:SetMenuKey(new: string | Enum.KeyCode)
		Config.Keybind = new;
	end;

	function WindowArgs:Update(config: WindowUpdate)
		config = config or {};
		config.Logo = config.Logo or Config.Logo;
		config.Username = config.Username or LocalPlayer.DisplayName;
		config.ExpireDate = config.ExpireDate or "NEVER";
		config.WindowName = config.WindowName or Config.Name;
		config.UserProfile = config.UserProfile or WindowArgs.Profile or string.format("rbxthumb://type=AvatarHeadShot&id=%s&w=150&h=150",tostring(LocalPlayer.UserId));

		if Compkiller.SecureMode and string.find(config.UserProfile, "rbxassetid://",1,true) then
			config.UserProfile = Compkiller:_GetIcon("user");
		end;

		UserText.Text = config.Username;
		CompLogo.Image = config.Logo;
		ExpireText.Text = config.ExpireDate;
		WindowLabel.Text = config.WindowName;
		UserProfile.Image = config.UserProfile;
		WindowArgs.Username = config.Username;

		Config.Logo = config.Logo or Config.Logo;
		WindowArgs.Username = config.Username or WindowArgs.Username;
		WindowArgs.ExipreDate = config.ExpireDate or WindowArgs.ExipreDate;
		Config.Name = config.WindowName or Config.Name;
		WindowArgs.Profile = config.UserProfile or WindowArgs.Profile;
	end;

	WindowArgs.LOOP_THREAD = task.spawn(function()
		local TimeTic = tick();

		local BlurElement = Instance.new("Frame")

		BlurElement.Name = Compkiller:_RandomString()
		BlurElement.Parent = MainFrame
		BlurElement.AnchorPoint = Vector2.new(1, 0.5)
		BlurElement.BackgroundTransparency = 1.000
		BlurElement.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlurElement.BorderSizePixel = 0
		BlurElement.Position = UDim2.new(1, -5, 0.5, 0)
		BlurElement.Size = UDim2.new(1, 0, 1, 0)
		BlurElement.ZIndex = -100
		BlurElement.Active = true

		Compkiller:_Blur(BlurElement , WindowOpen);

		local MovementFrame = Instance.new("Frame")

		MovementFrame.Name = Compkiller:_RandomString()
		MovementFrame.Parent = MainFrame
		MovementFrame.AnchorPoint = Vector2.new(1, 0.5)
		MovementFrame.BackgroundTransparency = 1.000
		MovementFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MovementFrame.BorderSizePixel = 0
		MovementFrame.Position = UDim2.new(1, 0, 0.5, 0)
		MovementFrame.Size = UDim2.new(1, 0, 1, 0)
		MovementFrame.ZIndex = 9

		Compkiller:Drag(MovementFrame,MainFrame,0)

		SelectionFrame.Position = UDim2.new(1, 5, 0, 28)
		SelectionFrame.Size = UDim2.new(0, 8, 0, 22)

		table.insert(Compkiller.Elements.Highlight,{
			Element = SelectionFrame,
			Property = "BackgroundColor3"
		});

		local function UpdateSelectionUI()
			local CurrentScale = WindowArgs.MainUIScale.Scale;
			BlurElement.Size = UDim2.new(1, (TabFrame.AbsoluteSize.X / CurrentScale) - 35, 1, 0);
			MovementFrame.Size = UDim2.new(1, (TabFrame.AbsoluteSize.X / CurrentScale) - 35, 1, 0);

			SelectionFrame.BackgroundColor3 = Compkiller.Colors.Highlight;

			if WindowArgs.SelectedTab and WindowArgs.IsOpen then
				local vili = -((TabButtons.AbsolutePosition.Y / CurrentScale) - (WindowArgs.SelectedTab.AbsolutePosition.Y / CurrentScale)) + 4;
				local distance = (SelectionFrame.Position.Y.Offset - vili);

				if vili < 0 or vili > (TabButtons.AbsoluteSize.Y / CurrentScale) then
					Compkiller:_Animation(SelectionFrame , TweenInfo.new(0.1) , {
						BackgroundTransparency = 1
					});
				else
					if math.abs(distance) <= 10 then
						Compkiller:_Animation(SelectionFrame , TweenInfo.new(0.1) , {
							BackgroundTransparency = 0
						});

						SelectionFrame.Position = UDim2.new(1,5,0,math.ceil(vili));
					else
						Compkiller:_Animation(SelectionFrame , TweenInfo.new(0.15) , {
							BackgroundTransparency = 0,
							Position = UDim2.new(1,5,0,math.ceil(vili))
						});
					end;
				end;
			else
				Compkiller:_Animation(SelectionFrame , TweenInfo.new(0.15) , {
					BackgroundTransparency = 1
				});
			end;

			if WindowArgs.AlwayShowTab then
				TabHover:Fire(true);
			end;
		end

		-- Instant response for size/position changes
		TabFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateSelectionUI)

		-- Slow fallback loop for tab selection changes (no signal available)
		task.spawn(function()
			while true do RunService.RenderStepped:Wait()
				UpdateSelectionUI()
			end
		end)
	end);

	WindowArgs:Update();

	local OldDelayThread;
	local DurationTime = tick();

	Compkiller:_Hover(TabFrame , function()
		if OldDelayThread then
			task.cancel(OldDelayThread);
			OldDelayThread = nil;
		end;

		if WindowArgs.AlwayShowTab then
			return;
		end;

		DurationTime = tick();

		TabHover:Fire(true);
	end , function()
		if OldDelayThread then
			task.cancel(OldDelayThread);
			OldDelayThread = nil;
		end;

		if WindowArgs.AlwayShowTab then
			return;
		end;

		OldDelayThread = task.delay(math.clamp((tick() - DurationTime) , 0.01,5),function()
			if TabHover:GetValue() then
				TabHover:Fire(false);
			end
		end);
	end);

	return WindowArgs;
end;

function Compkiller:GetDate(Time)
	Time = Time or tick();

	local val = os.date('*t',Time);

	return string.format("%s/%s/%s",val.day,val.month,val.year);
end;

function Compkiller:GetTimeNow(Time)
	Time = Time or tick();

	local val = os.date('*t',Time);

	return string.format("%s:%s:%s",val.hour,val.min,val.sec);
end;

function Compkiller:GetConfig(Type: string)
	local ConfigFlags = {};

	for i,v in next , Compkiller.Flags do
		local Value = v:GetValue();
		local Suf = {};

		if typeof(Value) == "table" and Value.ColorPicker and typeof(Value.ColorPicker) == 'table' then
			Suf.Color3 = {
				R = Value.ColorPicker.Color.R,
				G = Value.ColorPicker.Color.G,
				B = Value.ColorPicker.Color.B
			};

			Suf.Transparency = Value.ColorPicker.Transparency;

			Suf.Type = "ColorPicker";
		else
			Suf.Value = Value;
			Suf.Type = "NormalElement";
		end;

		if Type == "KV" then
			ConfigFlags[v.Flag] = {
				Flag = v.Flag,
				Value = Suf,
				Functions = v,
				AutoKeybind = (v.AutoKeybind and v.AutoKeybind:GetSettings());
			}
		elseif Type == "MK" then
			ConfigFlags[v.Flag] = {
				Flag = v.Flag,
				Value = Suf,
				AutoKeybind = (v.AutoKeybind and v.AutoKeybind:GetSettings());
			}
		else
			table.insert(ConfigFlags , {
				Flag = v.Flag,
				Value = Suf,
				AutoKeybind = (v.AutoKeybind and v.AutoKeybind:GetSettings());
			})
		end;
	end;

	return ConfigFlags;
end;

function Compkiller:_Path(...)
	local args = {...};

	return table.concat(args, "/");
end;

function Compkiller:ConfigManager(ConfigManager: ConfigManager) : ConfigFunctions
	ConfigManager = Compkiller.__CONFIG(ConfigManager , {
		Directory = "Compkiller",
		Config = "Software"
	});

	if not isfolder(ConfigManager.Directory) then
		makefolder(ConfigManager.Directory);
	end;

	if not isfolder(Compkiller:_Path(ConfigManager.Directory , ConfigManager.Config)) then
		makefolder(Compkiller:_Path(ConfigManager.Directory , ConfigManager.Config));
	end;

	local Args = {
		Directory = Compkiller:_Path(ConfigManager.Directory , ConfigManager.Config);
		EnableNotify = false,
	};

	local notify = Compkiller.newNotify();

	function Args:WriteConfig(Config: WriteConfig)
		Config = Compkiller.__CONFIG(Config , {
			Name = Compkiller:_RandomString(),
			Author = LocalPlayer.Name,
		});

		local Flags = Compkiller:GetConfig("MK");

		Flags["__INFORMATION"] = {
			Type = "Information",
			Author = Config.Author,
			Name = Config.Name,
			CreatedDate = Compkiller:GetDate()
		};

		if Args.EnableNotify then
			notify.new({
				Title = "Configs",
				Icon = Compkiller:_GetIcon('settings'),
				Content = "Create config \""..Config.Name.."\""
			})
		end

		writefile(Compkiller:_Path(Args.Directory , Config.Name) , HttpService:JSONEncode(Flags));
	end;

	function Args:LoadConfigFromString(str: string)
		local decoded = HttpService:JSONDecode(str);

		local Flags = Compkiller:GetConfig("KV");

		for i,v in next , decoded do
			if v and v.Flag then

				local Value = Flags[v.Flag];

				if Value then

					if v.Value.Type == "NormalElement" then
						Value.Functions:SetValue(v.Value.Value);

					elseif v.Value.Type == "ColorPicker" then

						local Color = Color3.new(v.Value.Color3.R,v.Value.Color3.G,v.Value.Color3.B);

						local Transparency = v.Value.Transparency;

						Value.Functions:SetValue(Color , Transparency);
					end;
				end;
			end
		end;
	end;

	function Args:GetCurrentConfig()
		return Compkiller:GetConfig("MK")
	end;

	function Args:ReadInfo(ConfigName: string)
		local _path = Compkiller:_Path(Args.Directory , ConfigName);

		if isfile(_path) then
			local info = readfile(_path);

			local decoded = HttpService:JSONDecode(info);

			return decoded.__INFORMATION;
		end;

		return false;
	end;

	function Args:GetConfigs()
		local names = {};

		for i,v in next , listfiles(Args.Directory) do
			local Name = string.sub(v , #Args.Directory + 2);

			table.insert(names , Name);
		end;

		return names;
	end;

	function Args:GetFullConfigs()
		local names = {};

		for i,v in next , listfiles(Args.Directory) do
			local Name = string.sub(v , #Args.Directory + 2);
			local Info = Args:ReadInfo(Name);

			table.insert(names , {
				Name = Name,
				Info = Info,
			});
		end;

		return names;
	end;

	function Args:DeleteConfig(ConfigName)
		local _path = Compkiller:_Path(Args.Directory,ConfigName);

		if Args.EnableNotify then
			notify.new({
				Title = "Configs",
				Icon = Compkiller:_GetIcon('settings'),
				Content = "Delete config \""..ConfigName.."\""
			})
		end

		if isfile(_path) then
			delfile(_path);
		end;
	end;

	function Args:GetConfigCount()
		return #listfiles(Args.Directory);
	end;

	function Args:LoadConfig(ConfigName: string)
		local _path = Compkiller:_Path(Args.Directory,ConfigName);

		if isfile(_path) then
			local info = readfile(_path);

			local decoded = HttpService:JSONDecode(info);

			local Flags = Compkiller:GetConfig("KV");

			if Args.EnableNotify then
				notify.new({
					Title = "Configs",
					Icon = Compkiller:_GetIcon('settings'),
					Content = "Load config \""..ConfigName.."\""
				})
			end

			for i,v in next , decoded do
				if v and v.Flag then

					local Value = Flags[v.Flag];

					if Value then

						if v.Value.Type == "NormalElement" then
							Value.Functions:SetValue(v.Value.Value);

						elseif v.Value.Type == "ColorPicker" then

							local Color = Color3.new(v.Value.Color3.R,v.Value.Color3.G,v.Value.Color3.B);

							local Transparency = v.Value.Transparency;

							Value.Functions:SetValue(Color , Transparency);
						end;

						if Value.Functions.AutoKeybind then
							if v.AutoKeybind then
								Value.Functions.AutoKeybind:LoadSettings(v.AutoKeybind)
							end;
						end;
					end;
				end
			end;
		end;
	end;

	return Args;
end;

function Compkiller:Loader(IconId,Duration)
	print("!!! COMPKILLER LOADER STARTED (NO ROTATION VERSION) !!!")
	local CompKiller = Instance.new("ScreenGui")

	CompKiller.Name = Compkiller:_RandomString()
	CompKiller.Parent = CoreGui
	CompKiller.Enabled = true
	CompKiller.ResetOnSpawn = false
	CompKiller.IgnoreGuiInset = true
	CompKiller.ZIndexBehavior = Enum.ZIndexBehavior.Global

	local Loader = Instance.new("Frame")
	local Icon = Instance.new("ImageLabel")
	local Vignette = Instance.new("ImageLabel")

	Loader.Name = Compkiller:_RandomString()
	Loader.Parent = CompKiller
	Loader.AnchorPoint = Vector2.new(0.5, 0.5)
	Loader.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Loader.BackgroundTransparency = 1
	Loader.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Loader.BorderSizePixel = 0
	Loader.Position = UDim2.new(0.5, 0, 0.5, 0)
	Loader.Size = UDim2.new(1, 0, 1, 0)

	Icon.Name = Compkiller:_RandomString()
	Icon.Parent = Loader
	Icon.AnchorPoint = Vector2.new(0.5, 0.5)
	Icon.BackgroundTransparency = 1.000
	Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Icon.BorderSizePixel = 0
	Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
	Icon.Size = UDim2.new(0, 300, 0, 300)
	Icon.ZIndex = 100
	Icon.Image = IconId or Compkiller.Logo;
	Icon.ImageTransparency = 1

	Vignette.Name = Compkiller:_RandomString()
	Vignette.Parent = Loader
	Vignette.BackgroundTransparency = 1.000
	Vignette.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Vignette.BorderSizePixel = 0
	Vignette.Size = UDim2.new(1, 0, 1, 0)
	Vignette.Image = Compkiller:CacheImage("rbxassetid://18720640102")
	Vignette.ImageColor3 = Compkiller.Colors.Highlight
	Vignette.ImageTransparency = 1
	Vignette.AnchorPoint = Vector2.new(0.5,0.5)
	Vignette.Position = UDim2.fromScale(0.5,0.5)

	Compkiller:_Animation(Loader,TweenInfo.new(0.55,Enum.EasingStyle.Quint),{
		BackgroundTransparency = 0.5
	});

	local Event = Instance.new('BindableEvent');

	task.delay(0.5,function()
		Compkiller:_Animation(Icon,TweenInfo.new(0.75,Enum.EasingStyle.Quint),{
			ImageTransparency = 0.01,
			Size = UDim2.new(0, 200, 0, 200)
		});

		-- Loading Bar UI
		local BarBackground = Instance.new("Frame")
		local BarFill = Instance.new("Frame")
		local BarCorner = Instance.new("UICorner")
		local FillCorner = Instance.new("UICorner")

		BarBackground.Name = "BarBackground"
		BarBackground.Parent = Loader
		BarBackground.AnchorPoint = Vector2.new(0.5, 1)
		BarBackground.Position = UDim2.new(0.5, 0, 0.85, 0)
		BarBackground.Size = UDim2.new(0, 300, 0, 4)
		BarBackground.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		BarBackground.BorderSizePixel = 0
		BarBackground.BackgroundTransparency = 1

		BarCorner.CornerRadius = UDim.new(1, 0)
		BarCorner.Parent = BarBackground

		BarFill.Name = "BarFill"
		BarFill.Parent = BarBackground
		BarFill.Size = UDim2.new(0, 0, 1, 0)
		BarFill.BackgroundColor3 = Compkiller.Colors.Highlight
		BarFill.BorderSizePixel = 0

		FillCorner.CornerRadius = UDim.new(1, 0)
		FillCorner.Parent = BarFill

		-- Fade in Bar Background
		Compkiller:_Animation(BarBackground, TweenInfo.new(0.5), {BackgroundTransparency = 0})

		-- Animate Bar Fill
		local loadTime = Duration or 4.5
		Compkiller:_Animation(BarFill, TweenInfo.new(loadTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)})

		task.delay(0.25,function()
			Compkiller:_Animation(Vignette,TweenInfo.new(5),{
				ImageTransparency = 0.2
			});

			task.wait(loadTime)

			Compkiller:_Animation(Vignette,TweenInfo.new(3,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				Size = UDim2.new(2, 0, 2, 0)
			});

			Compkiller:_Animation(Icon,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				ImageTransparency = 1,
			});
			
			-- Fade out Bar
			Compkiller:_Animation(BarBackground, TweenInfo.new(0.5), {BackgroundTransparency = 1})
			Compkiller:_Animation(BarFill, TweenInfo.new(0.5), {BackgroundTransparency = 1})

			Compkiller:_Animation(Loader,TweenInfo.new(1.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				BackgroundTransparency = 1
			});

			task.delay(0.1,function()
				Compkiller:_Animation(Vignette,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
					ImageTransparency = 1
				});

				task.wait(0.2)

				task.delay(3,function()
					CompKiller:Destroy();
				end)
			end)

			task.delay(0.6,function()
				Event:Fire();
			end)
		end)
	end);

	return {
		yield = function()
			return Event.Event:Wait();
		end	
	};
end;

function Compkiller.newNotify()
	if Compkiller.NOTIFY_CACHE then
		return Compkiller.NOTIFY_CACHE;
	end;

	local Notification = Instance.new("ScreenGui")
	local NotifyContainer = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	Notification.Name = Compkiller:_RandomString()
	Notification.Parent = CoreGui;
	Notification.ResetOnSpawn = false
	Notification.ZIndexBehavior = Enum.ZIndexBehavior.Global

	NotifyContainer.Name = Compkiller:_RandomString()
	NotifyContainer.Parent = Notification
	NotifyContainer.AnchorPoint = Vector2.new(1, 0)
	NotifyContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NotifyContainer.BackgroundTransparency = 1.000
	NotifyContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NotifyContainer.BorderSizePixel = 0
	NotifyContainer.Position = UDim2.new(1, -10, 0, 1)
	NotifyContainer.Size = UDim2.new(0, 100, 0, 100)

	UIListLayout.Parent = NotifyContainer
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 3)

	local LayoutREF = 0;

	Compkiller.NOTIFY_CACHE = {
		new = function(Notify: Notify) : NotifyPayback
			Notify = Compkiller.__CONFIG(Notify, {
				Icon = Compkiller.Logo,
				Title = "Notification",
				Content = "Content",
				Duration = 3,
			});

			LayoutREF -= 5;

			local BlockFrame = Instance.new("Frame")
			local NotifyFrame = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local CompLogo = Instance.new("ImageLabel")
			local Header = Instance.new("TextLabel")
			local Body = Instance.new("TextLabel")
			local TimeLeftFrame = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local TimeLeft = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")

			BlockFrame.Name = Compkiller:_RandomString()
			BlockFrame.Parent = NotifyContainer
			BlockFrame.AnchorPoint = Vector2.new(1, 0)
			BlockFrame.BackgroundColor3 = Compkiller.Colors.BGDBColor
			BlockFrame.BackgroundTransparency = 1.000
			BlockFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BlockFrame.BorderSizePixel = 0
			BlockFrame.ClipsDescendants = false
			BlockFrame.Size = UDim2.new(0, 200, 0, 0)
			BlockFrame.LayoutOrder = LayoutREF;


			NotifyFrame.Name = Compkiller:_RandomString()
			NotifyFrame.Parent = BlockFrame
			NotifyFrame.BackgroundColor3 = Compkiller.Colors.BGDBColor
			NotifyFrame.BackgroundTransparency = 0.100
			NotifyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NotifyFrame.BorderSizePixel = 0
			NotifyFrame.ClipsDescendants = false
			NotifyFrame.Size = UDim2.new(1, 0, 1, -5)
			NotifyFrame.ZIndex = 2
			NotifyFrame.Position = UDim2.new(1,200,0,0)


			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = NotifyFrame

			CompLogo.Name = Compkiller:_RandomString()
			CompLogo.Parent = NotifyFrame
			CompLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			CompLogo.BackgroundTransparency = 1.000
			CompLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
			CompLogo.BorderSizePixel = 0
			CompLogo.AnchorPoint = Vector2.new(0.5, 0.5)
			CompLogo.Position = UDim2.new(0, 20, 0, 18)
			CompLogo.Size = UDim2.new(0, 25, 0, 25)
			CompLogo.ZIndex = 4
			CompLogo.ScaleType = Enum.ScaleType.Fit
			CompLogo.Image = Compkiller:_GetIcon(Notify.Icon);
			CompLogo.ImageColor3 = Color3.new(1,1,1)

			if Compkiller.CustomHighlightMode and Notify.Icon ~= "default" and Notify.Icon ~= "" then
				CompLogo.ImageColor3 = Compkiller.Colors.Highlight;
			end;
			
			Header.Name = Compkiller:_RandomString()
			Header.Parent = NotifyFrame
			Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Header.BackgroundTransparency = 1.000
			Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Header.BorderSizePixel = 0
			Header.Position = UDim2.new(0, 40, 0, 10)
			Header.Size = UDim2.new(1, -50, 0, 15)
			Header.ZIndex = 3
			Header.Font = Enum.Font.GothamBold
			Header.Text = Notify.Title
			Header.TextColor3 = Compkiller.Colors.SwitchColor
			Header.TextSize = 14.000
			Header.TextXAlignment = Enum.TextXAlignment.Left

			Body.Name = Compkiller:_RandomString()
			Body.Parent = NotifyFrame
			Body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Body.BackgroundTransparency = 1.000
			Body.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Body.BorderSizePixel = 0
			Body.Position = UDim2.new(0, 40, 0, 33)
			Body.Size = UDim2.new(1, -50, 0, 30)
			Body.ZIndex = 3
			Body.Font = Enum.Font.GothamMedium
			Body.Text = Notify.Content
			Body.TextColor3 = Compkiller.Colors.SwitchColor
			Body.TextSize = 12.000
			Body.TextTransparency = 0.500
			Body.TextXAlignment = Enum.TextXAlignment.Left
			Body.TextYAlignment = Enum.TextYAlignment.Top

			TimeLeftFrame.Name = Compkiller:_RandomString()
			TimeLeftFrame.Parent = NotifyFrame
			TimeLeftFrame.AnchorPoint = Vector2.new(0, 1)
			TimeLeftFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TimeLeftFrame.BackgroundTransparency = 1.000
			TimeLeftFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TimeLeftFrame.BorderSizePixel = 0
			TimeLeftFrame.Position = UDim2.new(0, 0, 1, 1)
			TimeLeftFrame.Size = UDim2.new(1, 0, 0, 5)
			TimeLeftFrame.ZIndex = 5

			UICorner_2.CornerRadius = UDim.new(0, 4)
			UICorner_2.Parent = TimeLeftFrame

			TimeLeft.Name = Compkiller:_RandomString()
			TimeLeft.Parent = TimeLeftFrame
			TimeLeft.BackgroundColor3 = Compkiller.Colors.Highlight
			TimeLeft.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TimeLeft.BorderSizePixel = 0
			TimeLeft.Size = UDim2.new(0, 0, 1, 0)
			TimeLeft.ZIndex = 5

			UICorner_3.CornerRadius = UDim.new(0, 1)
			UICorner_3.Parent = TimeLeft

			local UpdateText = function()
				local TitleScale = TextService:GetTextSize(Header.Text,Header.TextSize,Header.Font,Vector2.new(math.huge,math.huge));
				local BodyScale = TextService:GetTextSize(Body.Text,Body.TextSize,Body.Font,Vector2.new(math.huge,math.huge));

				local MainX = (TitleScale.X >= BodyScale.X and TitleScale.X) or BodyScale.X;
				local MainY = TitleScale.Y + ((Body.Text:byte() and BodyScale.Y) or 1);

				if BlockFrame:GetAttribute('Already') then
					Compkiller:_Animation(BlockFrame,TweenInfo.new(0.3),{
						Size = UDim2.new(0,MainX + 55,0,MainY + 35)
					});
				else
					BlockFrame:SetAttribute('Already',true)
					BlockFrame.Size = UDim2.new(0, MainX + 45, 0, 0);

					Compkiller:_Animation(BlockFrame,TweenInfo.new(0.3),{
						Size = UDim2.new(0,MainX + 55,0,MainY + 35)
					});
				end;
			end;

			UpdateText();

			local Close = function()
				Compkiller:_Animation(NotifyFrame,TweenInfo.new(0.65,Enum.EasingStyle.Quint),{
					Position = UDim2.new(1,200,0,0)
				});

				task.wait(0.3);

				Compkiller:_Animation(BlockFrame,TweenInfo.new(0.3),{
					Size = UDim2.new(1,0,0,0)
				});

				task.wait(0.35)
				BlockFrame:Destroy();

			end;

			local Show = function()
				Compkiller:_Animation(NotifyFrame,TweenInfo.new(0.5,Enum.EasingStyle.Quint),{
					Position = UDim2.new(0,0,0,0)
				});
			end;

			if typeof(Notify.Duration) == 'number' and Notify.Duration ~= math.huge then
				Compkiller:_Animation(TimeLeft,TweenInfo.new(Notify.Duration + 0.2,Enum.EasingStyle.Linear),{
					Size = UDim2.new(1, 0, 1, 0)
				});

				return task.delay(0.25,function()
					Show();

					task.delay(Notify.Duration + 0.2,Close)
				end);
			end;

			Show();

			return {
				Title = function(self , new)
					Header.Text = new;
					UpdateText(); 
				end,

				Content = function(self , new)
					Body.Text = new;
					UpdateText();
				end,

				SetProgress = function(self , new , Time)
					if Time and Time <= 0 then
						TimeLeft.Size = UDim2.new(new, 0, 1, 0);

						UpdateText();
						return;
					end;

					if new > 1 then
						new = (new / 100);	
					end;

					Compkiller:_Animation(TimeLeft,TweenInfo.new(Time or 0.85,(Time and Enum.EasingStyle.Linear) or Enum.EasingStyle.Quint),{
						Size = UDim2.new(new, 0, 1, 0)
					});

					UpdateText();
				end,

				Close = Close,
			}
		end,
	};

	return Compkiller.NOTIFY_CACHE;
end;

Compkiller.NilFolder.Name = "Nil-Instances";

return Compkiller;
