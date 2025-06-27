/*
   Copyright (c) 2024 The Last Gameboard, Inc. All rights reserved.

   This software is confidential and proprietary information of The Last Gameboard, Inc.
   You may not disclose or distribute any portion of this code without 
   the prior written consent of The Last Gameboard, Inc.
*/

#if TOOLS
using Godot;
using System;
using System.Collections.Generic;

[Tool]
public partial class Plugin : EditorPlugin
{
	AndroidExportPlugin exportPlugin;
	public override void _EnterTree()
	{
		AddAutoloadSingleton("GameboardSDK", "res://addons/Gameboard/Gameboard.tscn");

		exportPlugin = new AndroidExportPlugin();
		AddExportPlugin(exportPlugin);
	}

	public override void _ExitTree()
	{
		RemoveAutoloadSingleton("GameboardSDK");

		RemoveExportPlugin(exportPlugin);
		exportPlugin = null;
	}

	private partial class AndroidExportPlugin : EditorExportPlugin
	{
		string _pluginName = "GameboardServiceClient";

		public override bool _SupportsPlatform(EditorExportPlatform platform)
		{
			return platform is EditorExportPlatformAndroid;
		}

		public override string[] _GetAndroidDependencies(EditorExportPlatform platform, bool debug)
		{
			var dependencies = new List<string>() {
				"com.lastgameboard.godot:godot-gameboard-service-client:0.0.28",
				"com.lastgameboard.core:gameboard-service-client:0.0.51",
				"com.lastgameboard.sdk:gameboardlytics:0.0.6",
				"com.lastgameboard.sdk:gameboard-settings-sdk:0.0.16"
			};
			return dependencies.ToArray();
		}

		public override string _GetName()
		{
			return _pluginName;
		}
	}
}
#endif
