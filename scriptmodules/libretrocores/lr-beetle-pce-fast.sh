#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-beetle-pce-fast"
rp_module_desc="PCEngine emu - Mednafen PCE Fast port for libretro"
rp_module_help="ROM Extensions: .pce .ccd .cue .zip\n\nCopy your PC Engine / TurboGrafx roms to $romdir/pcengine\n\nCopy the required BIOS file syscard3.pce to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/beetle-pce-fast-libretro/master/COPYING"
rp_module_section="lr"

function _update_hook_lr-beetle-pce-fast() {
    # move from old location and update emulators.cfg
    renameModule "lr-mednafen-pce-fast" "lr-beetle-pce-fast"
}

function sources_lr-beetle-pce-fast() {
    gitPullOrClone "$md_build" https://github.com/libretro/beetle-pce-fast-libretro.git
}

function build_lr-beetle-pce-fast() {
    make clean
    make
    md_ret_require="$md_build/mednafen_pce_fast_libretro.so"
}

function install_lr-beetle-pce-fast() {
    md_ret_files=(
        'mednafen_pce_fast_libretro.so'
        'README.md'
    )
}

function install_bin_lr-beetle-pce-fast() {
    downloadAndExtract "$__gitbins_url/lr-beetle-pce-fast.tar.gz" "$md_inst" 1
}

function configure_lr-beetle-pce-fast() {
    local system
    for system in pcengine pce-cd tg16 tg-cd; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 1 "$md_id" "$system" "$md_inst/mednafen_pce_fast_libretro.so"
        addSystem "$system"
    done
}
