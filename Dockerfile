FROM archlinux:base-devel as base

RUN pacman --sync --refresh --sysupgrade --noconfirm --noprogressbar --quiet
RUN pacman --sync --noconfirm --noprogressbar --quiet git namcap
#RUN pacman --sync --noconfirm --noprogressbar --quiet sudo fakeroot
RUN yes | pacman --sync -cc

RUN useradd --create-home --comment "Arch Build User" build
RUN usermod -aG wheel build
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir /w
RUN chown build /w

RUN touch /var/cache/pacman/not_mounted

COPY entrypoint.sh /

FROM scratch

LABEL org.opencontainers.image.authors="Sergii Fesenko"

ENV LANG=en_US.UTF-8
ENV HOME /home/build

WORKDIR /w

USER build

COPY --from=base / /

ENTRYPOINT [ "/entrypoint.sh", "makepkg" ]
CMD [ "--force", "--syncdeps", "--noconfirm", "--cleanbuild" ]
