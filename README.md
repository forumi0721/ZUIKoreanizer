# ZuiKoreanizer

## 개요
**ZuiKoreanizer**는 Xiaoxin Pad Pro 12.7의 한국어 사용을 위한 Magisk/Apatch 모듈입니다.

## 주요 기능 및 구현 방식
1. **한국 Locale 적용:** 시스템 전체에 한국 로케일을 적용합니다.
   - `framework.jar`, `services.jar`의 `test_mode` 설정 값을 변경하고 변경된 값만 후킹하여 다국어 처리를 구현합니다.
2. **이전 버전 한글 번역 적용:** 이전 버전의 한글 번역을 적용합니다.
   - RRO(Resource Runtime Overlay)를 이용한 다국어 처리 방식으로 구현합니다.
3. **Play Store 활성화:** Google Play 스토어를 활성화합니다.
4. **불필요한 앱/중국 앱 삭제:** 기본적으로 설치된 불필요한 앱 및 중국 앱을 삭제합니다.
5. **AP500U 활성화:** AP500U 기능을 활성화합니다.
6. **DRM 컨텐츠 재생을 위한 Widevine L3 강제 적용:** Widevine L3를 강제 적용하여 DRM 콘텐츠를 재생할 수 있게 합니다.
7. **Bootanimation 교체:** 부팅 애니메이션을 교체합니다.

## 소스 코드
소스 코드는 GitHub에서 확인할 수 있습니다: [ZuiKoreanizer 소스 코드](https://github.com/forumi0721/ZuiKoreanizer)

## License
이 프로젝트는 GPLv2 라이선스를 따릅니다. 자세한 내용은 [LICENSE](https://github.com/forumi0721/ZuiKoreanizer/blob/main/LICENSE)를 참고하세요.

## 설치 방법
1. **Magisk / Apatch 설치**
   - ZuiKoreanizer를 사용하려면 먼저 Magisk 또는 Apatch를 설치해야 합니다. (루팅된 기기에서만 가능)
2. **ZuiKoreanizer 다운로드 및 설치**
   - [Release 페이지](https://github.com/forumi0721/ZuiKoreanizer/releases)에서 최신 버전을 다운로드하여 설치합니다.
3. **모듈 설치**
   - Magisk / Apatch에서 ZuiKoreanizer 모듈을 설치합니다.

## 중요 사항
- ZuiKoreanizer는 Xiaoxin Pad Pro 12.7 664버전에서만 지원됩니다.

## 추가
- 추가 기능 확장을 위해서는 [ZuiTweak](https://github.com/forumi0721/ZuiTweak) 설치가 필요합니다.

## 문의
앱 사용 중 문제가 발생하거나 문의사항이 있으면 [Issues 페이지](https://github.com/forumi0721/ZuiKoreanizer/issues)를 통해 알려주세요.

## Credit
- [Magisk](https://github.com/topjohnwu/Magisk) by topjohnwu
- [APatch](https://github.com/bmax121/APatch) by bmax121
- [MMT-Extended](https://github.com/Zackptg5/MMT-Extended) by Zackptg5
- [갓파더](https://m.ppomppu.co.kr/new/bbs_view.php?id=androidtab&no=196040)

