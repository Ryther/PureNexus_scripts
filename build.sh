#!/bin/bash
# Bullhead (Nexus 5x) build

# Constants
DEVICES=2
SELECTION=1
TOOLCHAIN_SELECTION=1
TOOLCHAIN="UBERTC"
MENU_ITEMS=5
MENU_TOOLCHAIN_ITEMS=5

# Prepare the enviroment for building
source build/envsetup.sh &> /dev/null

# Set standard toolchain
if [ -d ~/android/Ryther/toolchains/UBERTC/aarch64/ ]
	then
		unlink ~/android/YAOSP/prebuilts/gcc/linux-x86/aarch64
		ln -s ~/android/Ryther/toolchains/UBERTC/aarch64/ ~/android/YAOSP/prebuilts/gcc/linux-x86/aarch64
fi
if [ -d ~/android/Ryther/toolchains/UBERTC/arm/ ]
	then
		unlink ~/android/YAOSP/prebuilts/gcc/linux-x86/arm
		ln -s ~/android/Ryther/toolchains/UBERTC/arm/ ~/android/YAOSP/prebuilts/gcc/linux-x86/arm
fi

# Prepare to build for selected model
while :
do
	# Displys the menu
	clear
	echo "-- Toolchain: $TOOLCHAIN"
	echo "-----------------------------------------"
	echo "|Select the model to build YAOSP on:    |"
	if [ "$SELECTION" == "1" ]
    	then
    	    echo "| * 1  --  Bullhead                     |"
    	else
    	    echo "|   1  --  Bullhead                     |"
	fi
	if [ "$SELECTION" == "2" ]
    	then
    	    echo "| * 2  --  HammerHead                   |"
    	else
    	    echo "|   2  --  HammerHead                   |"
	fi
	if [ "$SELECTION" == "3" ]
    	then
    	    echo "| * 3  --  All devices                  |"
    	else
    	    echo "|   3  --  All devices                  |"
	fi
	if [ "$SELECTION" == "4" ]
    	then
    	    echo "| * 4  --  Select toolchain             |"
    	else
    	    echo "|   4  --  Select toolchain             |"
	fi
	if [ "$SELECTION" == "5" ]
    	then
    	    echo "| * 5  --  Exit                         |"
    	else
    	    echo "|   5  --  Exit                         |"
	fi
	echo "========================================="
	echo "|Use - or + to move in the selection    |"
	
	# Save SELECTION
	TEMP_SELECTION=$SELECTION
	
	# Read the value, no enter required
	read -n 1 -p "|-> Make a choice or enter to confirm: " SELECTION
	echo "|"
	
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
			echo "========================================="
			echo "|          Bullhead selected            |"
			echo "-----------------------------------------"
			lunch aosp_bullhead-userdebug 
			DEVICES=SELECTION
			break ;;
		2) 
			echo "========================================="
			echo "|        Hammerheadhead selected        |"
			echo "-----------------------------------------"
			lunch aosp_hammerhead-userdebug 
			DEVICES=SELECTION
			break ;;
		3)
			echo "========================================="
			echo "|    Build for all devices selected     |"
			echo "-----------------------------------------"
			SELECTION=1
			break ;;
		4)
			# Toolchains' submenu start
			while :
			do
				# Displys the menu
				clear
				echo "-----------------------------------------"
				echo "|Select the toolchain to build with:    |"
				if [ "$TOOLCHAIN_SELECTION" == "1" ]
					then
						echo "| * 1  --  UBERTC 4.9 (standard)        |"
					else
						echo "|   1  --  UBERTC 4.9 (standard)        |"
				fi
				if [ "$TOOLCHAIN_SELECTION" == "2" ]
					then
						echo "| * 2  --  SaberMod 4.9                 |"
					else
						echo "|   2  --  SaberMod 4.9                 |"
				fi
				if [ "$TOOLCHAIN_SELECTION" == "3" ]
					then
						echo "| * 3  --  Linaro 4.9                   |"
					else
						echo "|   3  --  Linaro 4.9                   |"
				fi
				if [ "$TOOLCHAIN_SELECTION" == "4" ]
					then
						echo "| * 3  --  Back to devices              |"
					else
						echo "|   3  --  Back to devices              |"
				fi
				if [ "$TOOLCHAIN_SELECTION" == "5" ]
					then
						echo "| * 4  --  Exit                         |"
					else
						echo "|   4  --  Exit                         |"
				fi
				echo "========================================="
				echo "|Use - or + to move in the selection    |"
	
				# Save SELECTION
				TEMP_TOOLCHAIN_SELECTION=$TOOLCHAIN_SELECTION
	
				# Read the value, no enter required
				read -n 1 -p "|-> Make a choice or enter to confirm: " TOOLCHAIN_SELECTION
				echo "|"
	
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
						echo "|          UBERTC 4.9 selected          |"
						echo "-----------------------------------------"
						if [ -d ~/android/Ryther/toolchains/UBERTC/aarch64/ ]
							then
								unlink ~/android/YAOSP/prebuilts/gcc/linux-x86/aarch64
								ln -s ~/android/Ryther/toolchains/UBERTC/aarch64/ ~/android/YAOSP/prebuilts/gcc/linux-x86/aarch64
						fi
						if [ -d ~/android/Ryther/toolchains/UBERTC/arm/ ]
							then
								unlink ~/android/YAOSP/prebuilts/gcc/linux-x86/arm
								ln -s ~/android/Ryther/toolchains/UBERTC/arm/ ~/android/YAOSP/prebuilts/gcc/linux-x86/arm
						fi
						TOOLCHAIN="UBERTC"
						sleep 2
						break ;;
					2) 
						echo "========================================="
						echo "|         SaberMod 4.9 selected         |"
						echo "-----------------------------------------"
						if [ -d ~/android/Ryther/toolchains/SaberMod/aarch64/ ]
							then
								unlink ~/android/YAOSP/prebuilts/gcc/linux-x86/aarch64
								ln -s ~/android/Ryther/toolchains/SaberMod/aarch64/ ~/android/YAOSP/prebuilts/gcc/linux-x86/aarch64
						fi
						if [ -d ~/android/Ryther/toolchains/SaberMod/arm/ ]
							then
								unlink ~/android/YAOSP/prebuilts/gcc/linux-x86/arm
								ln -s ~/android/Ryther/toolchains/SaberMod/arm/ ~/android/YAOSP/prebuilts/gcc/linux-x86/arm
						fi
						TOOLCHAIN="SaberMod"
						sleep 2
						break ;;
					3) 
						echo "========================================="
						echo "|          Linaro 4.9 selected          |"
						echo "-----------------------------------------"
						if [ -d ~/android/Ryther/toolchains/Linaro/aarch64/ ]
							then
								unlink ~/android/YAOSP/prebuilts/gcc/linux-x86/aarch64
								ln -s ~/android/Ryther/toolchains/Linaro/aarch64/ ~/android/YAOSP/prebuilts/gcc/linux-x86/aarch64
						fi
						if [ -d ~/android/Ryther/toolchains/Linaro/arm/ ]
							then
								unlink ~/android/YAOSP/prebuilts/gcc/linux-x86/arm
								ln -s ~/android/Ryther/toolchains/Linaro/arm/ ~/android/YAOSP/prebuilts/gcc/linux-x86/arm
						fi
						TOOLCHAIN="Linaro"
						sleep 2
						break ;;
					4)
						echo "========================================="
						echo "|    Returning to devices selection     |"
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
	if [ ! -d ~/android/logs/stdout/YAOSP ]; then
		mkdir -p ~/android/logs/stdout/YAOSP
	fi
	if [ ! -d ~/android/logs/stderr/YAOSP ]; then
		mkdir -p ~/android/logs/stderr/YAOSP
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
				echo "|          Building $MODEL            |"
				echo "-----------------------------------------"
				lunch aosp_${MODEL}-userdebug ;;
			2) 
				MODEL="hammerhead"
				echo "========================================="
				echo "|         Building $MODEL           |"
				echo "-----------------------------------------"
				lunch aosp_${MODEL}-userdebug ;;
		esac

		# Start building
		time make -j$(( $N_CORES * 2 )) dist > >(tee ~/android/logs/stdout/YAOSP/stdout_build_${MODEL}_sh.log) 2> >(tee ~/android/logs/stderr/YAOSP/stderr_build_${MODEL}_sh.log >&2)
		echo "========================================="
		echo "|             Built $MODEL              |"
		echo "-----------------------------------------"
done
