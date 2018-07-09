- 打包 百 度OCR需要移除模拟器架构   

- http://ai.baidu.com/docs#/OCR-iOS-SDK/4cd935e9

- ```javascript
  cd ~/Desktop/JiuJiuWu/JiuJiuWu/Venders/BaiDuOCR
  # 使用lifo -info 可以查看包含的架构
  lipo -info AipBase.framework/AipBase  # Architectures in the fat file: AipBase are: i386 x86_64 armv7 armv7s arm64
  # 移除x86_64, i386
  lipo -remove x86_64 AipBase.framework/AipBase -o AipBase.framework/AipBase
  lipo -remove i386 AipBase.framework/AipBase -o AipBase.framework/AipBase
  lipo -remove x86_64 AipOcrSdk.framework/AipOcrSdk -o AipOcrSdk.framework/AipOcrSdk
  lipo -remove i386 AipOcrSdk.framework/AipOcrSdk -o AipOcrSdk.framework/AipOcrSdk
  # 再次查看
  lipo -info AipBase.framework/AipBase # Architectures in the fat file: AipBase are: armv7 armv7s arm64
  ```