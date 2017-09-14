FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 \
    && apt-get update -yq \
    && apt-get install -yq --no-install-recommends curl bzip2 git \
       scons build-essential libcunit1-dev cppcheck srecord \
       ca-certificates libc6:i386 libstdc++6:i386 libexpat1:i386

# Download and install GNU Arm Embedded Toolchain
RUN curl -sL https://developer.arm.com/-/media/Files/downloads/gnu-rm/6-2017q2/gcc-arm-none-eabi-6-2017-q2-update-linux.tar.bz2 | tar xvj -C /opt
ENV GCC_ARM_DIR /opt/gcc-arm-none-eabi-6-2017-q2-update
ENV PATH $GCC_ARM_DIR/bin:$PATH

# Download and install XC32 compiler
# Copied from https://github.com/analogic/mplabx
RUN curl -fsSL -A "Mozilla/4.0" -o /tmp/xc32.run "http://www.microchip.com/mplabxc32linux" \
    && chmod a+x /tmp/xc32.run \
    && /tmp/xc32.run --mode unattended --unattendedmodeui none \
        --netservername localhost --LicenseType FreeMode \
    && rm /tmp/xc32.run
ENV XC32_DIR /opt/microchip/xc32/v1.44
ENV PATH $XC32_DIR/bin:$PATH

# Harmony
# Copied from https://github.com/analogic/mplabx
RUN curl -fsSL -A "Mozilla/4.0" -o /tmp/harmony.run "http://www.microchip.com/mymicrochip/filehandler.aspx?ddocname=en599907" \
    && chmod a+x /tmp/harmony.run \
    && /tmp/harmony.run --mode unattended --unattendedmodeui none \
       --prefix /opt/microchip/harmony \
    && rm /tmp/harmony.run

WORKDIR /work
VOLUME /work

ENTRYPOINT ["/bin/bash"]
