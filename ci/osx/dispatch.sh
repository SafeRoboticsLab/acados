#!/bin/bash

if [ "${SECTION}" = 'before_install' ]; then
	# export GENERIC target for osx
	export BLASFEO_TARGET=GENERIC
	export HPIPM_TARGET=GENERIC
fi

if [ "${SECTION}" = 'install' ]; then
	source "${SCRIPT_DIR}/install_ccache.sh";
	source "${SHARED_SCRIPT_DIR}/install_eigen.sh";

	if [ 0
		 -o "${SWIG_MATLAB}" = 'ON'
		 -o "${SWIG_PYTHON}" = 'ON'
		 -o "${TEMPLATE_PYTHON}" = 'ON'
		 -o "${TEMPLATE_MATLAB}" = 'ON'
		 -o "${DEV_MATLAB}" = 'ON'
		]; then
		source "${SCRIPT_DIR}/install_casadi.sh";
	fi

	if [ 0
		 -o "${SWIG_PYTHON}" = 'ON'
		 -o "${TEMPLATE_PYTHON}" = 'ON'
		]; then
		source "${SCRIPT_DIR}/install_python_dependencies.sh";
	fi

	if [ 0
		 -o "${SWIG_MATLAB}" = 'ON'
		 -o "${TEMPLATE_MATLAB}" = 'ON'
		 -o "${DEV_MATLAB}" = 'ON'
		]; then
		source "${SHARED_SCRIPT_DIR}/install_matlab.sh";
	fi

	if [ 0
		 -o "${SWIG_MATLAB}" = 'ON'
		 -o "${SWIG_PYTHON}" = 'ON'
		]; then
		source "${SHARED_SCRIPT_DIR}/install_swig.sh";
	fi

elif [ "${SECTION}" = 'script' ]; then
	source "${SHARED_SCRIPT_DIR}/script_acados_release.sh";

elif [ "${SECTION}" = 'after_success' ]; then
	source "${SHARED_SCRIPT_DIR}/after_success_package_release.sh";

fi
