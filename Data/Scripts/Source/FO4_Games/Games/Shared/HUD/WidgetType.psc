Scriptname Games:Shared:HUD:WidgetType extends Quest Native Const Hidden
{The base type for hud framework widgets.}

Struct WidgetData
	string ID = "I_Forgot_To_Set_A_Widget_ID"
	{The path to your widget's SWF file. The root directory is "Data\Interface".}

	bool LoadNow = false
	{Load the widget immediately after registration. (default: false)}

	bool AutoLoad = false
	{Automatically load the widget whenever the game starts. (default: false)}

	int X = 0
	{The X axis coordinates to position the HUD widget.}

	int Y = 0
	{The Y axis coordinates to position the HUD widget.}

	float ScaleX = 1.0
	{The X axis scaling to transform the HUD widget.}

	float ScaleY = 1.0
	{The Y axis scaling to transform the HUD widget.}

	float Opacity = 1.0
	{The new opacity of the HUD widget. Ranges from 0 to 1.}
EndStruct


; Methods
;---------------------------------------------

Function Setup() Native
{Retrieves a reference to the HUDFramework and configures widget data.}

Function Register() Native
{The widget must be registered with HUDFramework before it can be loaded.}

Function Unregister() Native
{Unregisters the widget from HUDFramework. Unloads the widget if it is currently loaded.}

bool Function Load() Native
{Loads the widget.}

bool Function Unload() Native
{Unloads the widget.}

Function Update() Native
{Updates the widget.}


; Callbacks
;---------------------------------------------

Function HUD_WidgetLoaded(string widgetID) Native
{Callback, HUDFramework has loaded this widget.}
; You must implement the function HUD_WidgetLoaded(string asWidgetID) to be notified when your
; widget is loaded and ready to receive messages. You should not attempt to communicate with
; your widget before it is loaded.


; Virtual
;---------------------------------------------

Event OnSetup(WidgetData widget) Native
{Required, extending scripts must configure all widget data values.}

Event OnRegistered() Native
{The widget has been registered with HUDFramework.}

Event OnUnregistered() Native
{The widget has been unregistered from the HUDFramework.}

Event OnLoaded() Native
{The widget has loaded.}

Event OnUnloaded() Native
{The widget has unloaded.}

Event OnUpdated() Native
{The widget has updated.}
