## Xiaomi Redmi Note 13 Pro 5G / POCO X6 5G (_garnet_)
## AERA Recovery device tree

## Device specifications

Device                  | Xiaomi Redmi Note 13 Pro 5G / POCO X6 5G
-----------------------:|:-----------------------------------------
SoC                     | Qualcomm SM7435-AB Snapdragon 7s Gen 2 (4 nm)
CPU                     | Octa-core (4x2.40 GHz Cortex-A78 & 4x1.95 GHz Cortex-A55)
GPU                     | Adreno 710
Memory                  | 8/12 GB RAM
Storage                 | 256/512 GB (UFS 2.2)
MicroSD                 | None
Shipped Android Version | 13.0
Battery                 | Non-removable Li-Po 5100 mAh
Display                 | 1220 x 2712 pixels, 20:9 ratio (~446 ppi density), 6.67 inches
Camera                  | 64 MP (wide), 8 MP (ultrawide), 2 MP (macros); 16 MP (front, wide)

## Device picture

![ Xiaomi Redmi Note 13 Pro 5G / POCO X6 5G ](https://i05.appmifile.com/782_item_uk/02/01/2024/64b665041c6304906361e93d1b709fb7!600x600!85.png "Xiaomi Redmi Note 13 Pro 5G / POCO X6 5G")

## Features

Works:

- [X] ADB
- [X] Decryption
- [X] Display
- [X] Fasbootd
- [X] Flashing
- [X] MTP
- [X] Sideload
- [X] USB OTG
- [X] Vibrator

## Building

Sync the AERA sources and the `device/xiaomi/sm84xx-common` dependency, then run:

```
source build/envsetup.sh
lunch twrp_garnet-bp2a-eng
mka recoveryimage
```

## Credits
- [Original garnet tree by nebrassy](https://github.com/nebrassy/device_xiaomi_garnet-TWRP.git)

### Copyright
 ```
  /*
  *  Copyright (C) 2024 The OrangeFox Recovery Project
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
  */
  ```
