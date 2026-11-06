# VOIDWAKE — Rook Works interface update 0.7

Extract the ZIP and run **build-0.7/Voidwake-0.7.exe** with **libvoxel.windows.template_release.x86_64.dll** beside it. Choose **New expedition**, the middle **Cinder Reach** branch, then **Harrow**. Lucent and ringed Ilex are flyby bodies in this slice. **Continue** opens the same save slot used by 0.6 and can import older expeditions.

## Rook Works

The cockpit has separate instruments for hull and crew, flight, and current field work. Aim near a surveyed location or working crew for a contextual readout. A finished pass no longer leaves a windshield label; its crew can be recalled or reassigned from field dispatch or the crew manifest.

The expedition chart highlights reachable jumps and travelled routes. Select a node to inspect the encounter, then set course to commit. Select a body in the 3D system view and choose **Approach** to fly there.

On the equipment screen, click an item or press **1–3** or **Left / Right** to inspect. Choose **Install selected** separately to purchase it. If you're short, **Bank & continue** keeps the full balance. Menus support **Tab**, **Shift+Tab** and **Enter**. Settings offers text sizes of **100%, 115% and 130%**, plus reduced interface motion.

See the [three visual studies and reference notes](design-exploration/Design%20notes.md), [in-game captures](ui-preview-0.7/) and [Windows verification](VALIDATION-0.7.md).

## Playing

Choose a connected destination on the frontier chart. The gold routes show your next jumps. Cinder Reach contains Harrow, a 480 km-wide world with a mineral corridor and an inhabited works. Drag with either mouse button to rotate around Sere and scroll to zoom. Select Harrow to watch the Rook approach. The cockpit takes over above the atmosphere. Use **B** for the long descent and disengage cruise or brake before passing your target. Follow the Rook Shelf bearing, then scan within 3.2 km for the deposit type and depth. Use local flight for the final approach. The flight manual is available from the title menu or with **F1**.

Scan the terrain, aim at a position and right-click to create an allocation waypoint. Select a crew type and quantity. Extractors work in finite 12-cut passes:

- **Expose** drills down through the surface.
- **Follow vein** steers toward the nearest deposit's buried pockets.
- **Bore tunnel** follows the direction you aimed, with a downward bias.

Crews stop after a pass and remain deployed. Tab cycles existing waypoints so you can order another pass or recall. Couriers deliver recovered material periodically; recall also recovers undelivered cargo. Ordinary rock remains diggable after the valuable ore is gone. Repeated cuts through empty space produce no extra resources.

Abductors require a settlement and capture its population independently of mining. Cities have physical buildings: removing their foundations can collapse them and reduce the remaining population. Gunners suppress defences, while engineers accelerate excavation. Deployed crew leave their onboard defence and repair stations.

Working extraction can expose you. Inhabited worlds immediately report hostile actions. From detection, the ISP takes **2:00–3:15** to arrive, depending on system risk and whether you carried a lookout star. Local defenders wait before launching and attack in spaced waves. ISP arrival still brings overwhelming fire. Escape before arrival clears the trail; a late escape retains one lookout star.

**Space warps immediately**, abandoning unrecalled and returning workers and undelivered cargo. Your hold sells automatically, followed by three upgrade offers. Choose one or bank the haul. **J** leaves for the current solar system, with the same sale and upgrade step, allowing another planetary visit.

## Controls

| Input | Action |
|---|---|
| Mouse | Steer ship |
| W / S | Forward / reverse thrust |
| A / D | Strafe |
| Q / E | Descend / ascend relative to planet |
| X | Strong brakes and cancel cruise |
| Shift | Precision flight |
| Ctrl + directional thrust | Hold for orbital boost. Harrow limits cruise speed closer to the terrain |
| B | Toggle forward cruise boost |
| O | Toggle orbit assistance |
| Z | Magnify |
| C or Shift + left-click | Scan deposits and cities |
| Right-click | Place surface waypoint / close allocation |
| Left-click | Personal anti-missile gun |
| Tab | Cycle allocation waypoints |
| Enter | Deploy selected crew |
| R | Recall selected waypoint's crew |
| Space | Emergency warp to frontier chart |
| J | Depart for current solar system |
| Escape | Close tool / pause |
| F1 | Flight manual |
| M | Toggle audio |

## Progression and destruction

Upgrades improve drilling, excavation width, logistics, interception, hull, stealth, abduction, sale value and flight. Wider advanced bores consume credits per cut; starter excavation is free. Each departure offers three distinct choices, priced at `25 + 8 × route step` credits. Merchants offer repairs, recruits and extra upgrades. Balancing remains provisional.

On Harrow, spherical mesh patches refine around the ship throughout the descent. A shared elevation field drives these patches and the native signed-distance volume. Native meshes replace the ground around the nearest ready excavated site within local operating range. Other cuts remain in the edit ledger and terrain database. Regolith covers basalt, ferrite and cobalt pockets. Crews use landers and a visible boring head during extraction. Disconnected local terrain can become physical fragments. The legacy endgame checks for eight distinct deep crustal faults to trigger fragmentation.

Global breakup uses coarse wedges derived from the remaining radial surface. Local excavation is volumetric; whole-world breakup is a simplified endgame effect, not a complete structural simulation. Fragmented worlds remain debris fields on the system map and cannot be approached again in this build.

## Saves

The 0.5 slot is `%APPDATA%/Godot/app_userdata/VOIDWAKE/expedition-v5.save`, with a `.bak` recovery copy. Continue can read the 0.4 and 0.3 checkpoints. Harrow uses `terrain-harrow/<run seed>/`. Imported bodies use their original generator and database. Checkpoints include the route history, current system, ship pose, crew, credits, offers, upgrades and excavation ledger. Saves occur on transitions, on departure before the warp finishes, every 12 seconds during flight and when closing. **Escape → Save and exit** suspends an encounter.

## Develop and build

Open `source/project.godot` in **Godot 4.7.2 Standard, Windows x64**. Voxel Tools 1.7 supplies the native terrain backend. This Windows package includes its editor and release DLLs; obtain matching upstream binaries before targeting another platform.

```powershell
.\Build.ps1 -Godot 'C:\path\to\Godot_v4.7.2-stable_win64_console.exe' -TemplatePath 'C:\path\to\windows_release_x86_64.exe'
```

Run the gameplay integration checks:

```powershell
& 'C:\path\to\Godot_v4.7.2-stable_win64_console.exe' --headless --path .\source -- --self-test
```

Checks exercise native terrain, persistence, bounded orders, crew accounting, abduction, foundation collapse, ISP response, upgrades and fracture triggering. `CORE-REVIEW.md` contains the diagnosis, code examples and two-process checkpoint test. See `VALIDATION-0.7.md` and `validation-0.7.txt` for this build’s results.

## Current scope

The benchmark covers one complete expedition through Cinder Reach. The chart continues into the existing seeded route beyond that system. Harrow uses a 34 m/s starter speed in local flight and a 340 m/s starter boost in the upper approach, with clearance lookahead and a lower speed near terrain. Heavy concurrent mining and long expeditions still need performance testing.

## Credits

The Rook, field lander, bore head, processor, habitat and landing pad are original models. Their editable Blender scene is in `art/Industrial Kit.blend`. The 12 original equipment renders can be regenerated with `blender -b -t 4 --python art/render-equipment.py -- <output-directory>`. Harrow uses the CC0 Aerial Rocks 02 diffuse, normal and roughness maps by Rob Tuytel. [Poly Haven asset and license](https://polyhaven.com/a/aerial_rocks_02)

Godot Engine is MIT-licensed: `GODOT-LICENSE.txt` and `GODOT-COPYRIGHT.txt`. Voxel Tools is MIT-licensed, copyright Marc Gilleron: `VOXEL-TOOLS-LICENSE.txt` and the source addon's notice. The terrain transition shader follows its documented mesh attributes. Upstream: [Voxel Tools](https://github.com/Zylann/godot_voxel).
