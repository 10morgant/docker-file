#
# borrowed a lot of support from https://github.com/aBARICHELLO/godot-ci/blob/master/mono.Dockerfile
#
FROM mono:latest

USER root
# so that no question/dialog is asked during apt-get install
ENV DEBIAN_FRONTEND=noninteractive 


RUN apt-get -qq update \
    && apt-get -qq install -y \
    ca-certificates \
    git \
    # bash \
    # git-lfs \
    # python3 \
    # python-openssl \
    unzip \
    wget \
    zip \
    && rm -rf /var/lib/apt/lists/*

# The godot version to use
# should always use stable, can use beta if needed
ENV VERSION "3.2.3"
ENV RELEASE_NAME "stable"

# download the headless, linux, MONO godot  (72 MB)
# download the export templates (595 MB), handy for you know, exporting

# explicitly make the: 
# - cache
# - config
# - local
# folders
# Unzip the headless build and move it to "/usr/local/bin/godot" 
# as this is where binaries typically live in linux when provided by the user
# move godotsharp to /usr/local/bin/GodotSharp for the same reason
# unzip the export templates
# move them to their folder in ~/.local/share/godot/templates/ver.release.mono
# 

RUN wget -q https://downloads.tuxfamily.org/godotengine/${VERSION}/mono/Godot_v${VERSION}-${RELEASE_NAME}_mono_linux_headless_64.zip \
    && wget -q https://downloads.tuxfamily.org/godotengine/${VERSION}/mono/Godot_v${VERSION}-${RELEASE_NAME}_mono_export_templates.tpz \
    && mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && mkdir -p ~/.local/share/godot/templates/${VERSION}.${RELEASE_NAME}.mono \
    && unzip -qq Godot_v${VERSION}-${RELEASE_NAME}_mono_linux_headless_64.zip \
    && mv Godot_v${VERSION}-${RELEASE_NAME}_mono_linux_headless_64/Godot_v${VERSION}-${RELEASE_NAME}_mono_linux_headless.64 /usr/local/bin/godot \
    && mv Godot_v${VERSION}-${RELEASE_NAME}_mono_linux_headless_64/GodotSharp /usr/local/bin/GodotSharp \
    && unzip -qq Godot_v${VERSION}-${RELEASE_NAME}_mono_export_templates.tpz \
    && mv templates/* ~/.local/share/godot/templates/${VERSION}.${RELEASE_NAME}.mono \
    && rm -f Godot_v${VERSION}-${RELEASE_NAME}_mono_export_templates.tpz Godot_v${VERSION}-${RELEASE_NAME}_mono_linux_headless_64.zip 


