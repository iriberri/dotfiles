PREFIX="${PREFIX:-/usr/local}"

if [[ -d $PREFIX/share/chruby/ ]]; then
	source $PREFIX/share/chruby/chruby.sh
	source $PREFIX/share/chruby/auto.sh
fi
