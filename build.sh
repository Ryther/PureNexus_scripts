#!/bin/bash
# ${ROM_NAME} build helper

# Constants
ROM_NAME="PureNexus"
BUILD_ROOT_PATH="~/android/${ROM_NAME}"
CUSTOM_ROOT_PATH="~/android/Ryther"
LUNCH_PREFIX="nexus"
LUNCH_SUFFIX="user"
DEVICES=2
SELECTION=1
TOOLCHAIN_SELECTION=1
TOOLCHAIN="UBERTC"
MENU_ITEMS=5
MENU_TOOLCHAIN_ITEMS=5

# Prepare the enviroment for building
source build/envsetup.sh &> /dev/null

# Set standard toolchain
if [ -d ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/aarch64/ ]
	then
		unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
		ln -s ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/aarch64/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
fi
if [ -d ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/arm/ ]
	then
		unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm
		ln -s ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/arm/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm
fi

# Prepare to build for selected model
while :
do
	# Displys the menu
	clear
	echo "-- Toolchain: $TOOLCHAIN"
	echo "---------------------------------------------"
	echo " Select the model to build ${ROM_NAME} on:     "
	if [ "$SELECTION" == "1" ]
    	then
    	    echo "  * 1  --  Bullhead                          "
    	else
    	    echo "    1  --  Bullhead                          "
	fi
	if [ "$SELECTION" == "2" ]
    	then
    	    echo "  * 2  --  HammerHead                        "
    	else
    	    echo "    2  --  HammerHead                        "
	fi
	if [ "$SELECTION" == "3" ]
    	then
    	    echo "  * 3  --  All devices                       "
    	else
    	    echo "    3  --  All devices                       "
	fi
	if [ "$SELECTION" == "4" ]
    	then
    	    echo "  * 4  --  Select toolchain                  "
    	else
    	    echo "    4  --  Select toolchain                  "
	fi
	if [ "$SELECTION" == "5" ]
    	then
    	    echo "  * 5  --  Exit                              "
    	else
    	    echo "    5  --  Exit                              "
	fi
	echo "============================================="
	echo " Use - or + to move in the selection         "
	
	# Save SELECTION
	TEMP_SELECTION=$SELECTION
	
	# Read the value, no enter required
	read -n 1 -p " -> Make a choice or enter to confirm: " SELECTION
	
	# Check for enter command, start the current selection
	if [ "$SELECTION" == "" ]
    	then
    	    SELECTION=$TEMP_SELECTION
	fi
	
	# Selection case
	case $SELECTION in
		# Move up in the menu
		"-") 
		    if [ "$TEMP_SELECTION" == "1" ]
		        then
		            SELECTION=$MENU_ITEMS
		        else
		            SELECTION=$(( $TEMP_SELECTION - 1 ))
		    fi
		    continue ;;
		# Move down in the menu
		"+") 
		    if [ "$TEMP_SELECTION" == "$MENU_ITEMS" ]
		        then
		            SELECTION=1
		        else
		            SELECTION=$(( $TEMP_SELECTION + 1 ))
		    fi
		    continue ;;
		# Real selection
		1)
			echo "============================================="
			echo "             Bullhead selected               "
			echo "---------------------------------------------" 
			DEVICES=SELECTION
			break ;;
		2) 
			echo "============================================="
			echo "           Hammerheadhead selected           "
			echo "---------------------------------------------"
			DEVICES=SELECTION
			break ;;
		3)
			echo "============================================="
			echo "       Build for all devices selected        "
			echo "---------------------------------------------"
			SELECTION=1
			break ;;
		4)
			# Toolchains' submenu start
			while :
			do
				# Displys the menu
				clear
				echo "-----------------------------------------"
				echo " Select the toolchain to build with:     "
				if [ "$TOOLCHAIN_SELECTION" == "1" ]
					then
						echo "  * 1  --  UBERTC 4.9 (standard)         "
					else
						echo "    1  --  UBERTC 4.9 (standard)         "
				fi
				if [ "$TOOLCHAIN_SELECTION" == "2" ]
					then
						echo "  * 2  --  SaberMod 4.9                  "
					else
						echo "    2  --  SaberMod 4.9                  "
				fi
				if [ "$TOOLCHAIN_SELECTION" == "3" ]
					then
						echo "  * 3  --  Linaro 4.9                    "
					else
						echo "    3  --  Linaro 4.9                    "
				fi
				if [ "$TOOLCHAIN_SELECTION" == "4" ]
					then
						echo "  * 3  --  Back to devices               "
					else
						echo "    3  --  Back to devices               "
				fi
				if [ "$TOOLCHAIN_SELECTION" == "5" ]
					then
						echo "  * 4  --  Exit                          "
					else
						echo "    4  --  Exit                          "
				fi
				echo "========================================="
				echo " Use - or + to move in the selection     "
	
				# Save SELECTION
				TEMP_TOOLCHAIN_SELECTION=$TOOLCHAIN_SELECTION
	
				# Read the value, no enter required
				read -n 1 -p " -> Make a choice or enter to confirm: " TOOLCHAIN_SELECTION
	
				# Check for enter command, start the current selection
				if [ "$TOOLCHAIN_SELECTION" == "" ]
					then
						TOOLCHAIN_SELECTION=$TEMP_TOOLCHAIN_SELECTION
				fi
	
				# Selection case
				case $TOOLCHAIN_SELECTION in
					# Move up in the menu
					"-") 
						if [ "$TEMP_TOOLCHAIN_SELECTION" == "1" ]
							then
								TOOLCHAIN_SELECTION=$MENU_TOOLCHAIN_ITEMS
							else
								TOOLCHAIN_SELECTION=$(( $TEMP_TOOLCHAIN_SELECTION - 1 ))
						fi
						continue ;;
					# Move down in the menu
					"+") 
						if [ "$TEMP_TOOLCHAIN_SELECTION" == "$MENU_TOOLCHAIN_ITEMS" ]
							then
								TOOLCHAIN_SELECTION=1
							else
								TOOLCHAIN_SELECTION=$(( $TEMP_TOOLCHAIN_SELECTION + 1 ))
						fi
						continue ;;
					# Real selection
					1)
						echo "========================================="
						echo "           UBERTC 4.9 selected           "
						echo "-----------------------------------------"
						if [ -d ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/aarch64/ ]
							then
								unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
								ln -s ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/aarch64/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
						fi
						if [ -d ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/arm/ ]
							then
								unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm
								ln -s ${CUSTOM_ROOT_PATH}/toolchains/UBERTC/arm/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm
						fi
						TOOLCHAIN="UBERTC"
						sleep 2
						break ;;
					2) 
						echo "========================================="
						echo "          SaberMod 4.9 selected          "
						echo "-----------------------------------------"
						if [ -d ${CUSTOM_ROOT_PATH}/toolchains/SaberMod/aarch64/ ]
							then
								unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
								ln -s ${CUSTOM_ROOT_PATH}/toolchains/SaberMod/aarch64/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
						fi
						if [ -d ${CUSTOM_ROOT_PATH}/toolchains/SaberMod/arm/ ]
							then
								unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm
								ln -s ${CUSTOM_ROOT_PATH}/toolchains/SaberMod/arm/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm
						fi
						TOOLCHAIN="SaberMod"
						sleep 2
						break ;;
					3) 
						echo "========================================="
						echo "           Linaro 4.9 selected           "
						echo "-----------------------------------------"
						if [ -d ${CUSTOM_ROOT_PATH}/toolchains/Linaro/aarch64/ ]
							then
								unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
								ln -s ${CUSTOM_ROOT_PATH}/toolchains/Linaro/aarch64/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/aarch64
						fi
						if [ -d ${CUSTOM_ROOT_PATH}/toolchains/Linaro/arm/ ]
							then
								unlink ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm
								ln -s ${CUSTOM_ROOT_PATH}/toolchains/Linaro/arm/ ${BUILD_ROOT_PATH}/prebuilts/gcc/linux-x86/arm
						fi
						TOOLCHAIN="Linaro"
						sleep 2
						break ;;
					4)
						echo "========================================="
						echo "     Returning to devices selection      "
						echo "-----------------------------------------"
						sleep 2
						break ;;
					5)
						echo "           Exiting script...          "
						exit ;;
					*)
						echo "        Wrong value. Try again.       " 
						sleep 2 ;;
				esac
			done ;;
			# Toolchains' submenu end
		5)
			echo "           Exiting script...          "
			exit ;;
		*)
			echo "        Wrong value. Try again.       " 
			sleep 1 ;;
	esac
done

#Check for required logs dir and create them if necessary
	if [ ! -d ${CUSTOM_ROOT_PATH}/logs/stdout/${ROM_NAME} ]; then
		mkdir -p ${CUSTOM_ROOT_PATH}/logs/stdout/${ROM_NAME}
	fi
	if [ ! -d ${CUSTOM_ROOT_PATH}/logs/stderr/${ROM_NAME} ]; then
		mkdir -p ${CUSTOM_ROOT_PATH}/logs/stderr/${ROM_NAME}
	fi

# Check numbers of core to optimize building
	N_CORES=$(grep -c ^processor /proc/cpuinfo)

# Cleaning the previus build
	make clean

# Building operations, if a specific device is selected, the for run only once for the specific device
for (( i=SELECTION; i<=$DEVICES; i++ ))
	do
		case $i in
			1)
				MODEL="bullhead"
				echo "========================================="
				echo "           Building $MODEL             "
				echo "-----------------------------------------"
				lunch ${LUNCH_PREFIX}_${MODEL}-${LUNCH_SUFFIX} ;;
			2) 
				MODEL="hammerhead"
				echo "========================================="
				echo "          Building $MODEL            "
				echo "-----------------------------------------"
				lunch ${LUNCH_PREFIX}_${MODEL}-${LUNCH_SUFFIX} ;;
		esac

		# Start building
		time make -j$(( $N_CORES * 2 )) dist > >(tee ${CUSTOM_ROOT_PATH}/logs/stdout/${ROM_NAME}/stdout_build_${MODEL}_sh.log) 2> >(tee ${CUSTOM_ROOT_PATH}/logs/stderr/${ROM_NAME}/stderr_build_${MODEL}_sh.log >&2)
		echo "========================================="
		echo "              Built $MODEL            "
		echo "-----------------------------------------"
done
