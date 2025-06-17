# 💑 Couple D-Day Counter

Swift로 제작된 iOS 미니 프로젝트로, 커플을 위한 D-Day 계산기 및 감성 배경 음악 재생 기능을 제공합니다.

<br/>
발표 영상(Youtube): https://youtu.be/ROvpBN_RnQI
<br />
<br />

## 📱 주요 기능

- **D-Day 계산기**
  - 시작일 선택 → 오늘 날짜 기준으로 D+N 표시
  - 계산식: `오늘 - 시작일 + 1`
  - UIDatePicker(.inline) 스타일로 달력 UI 제공

- **배경 음악 기능**
  - 5개의 BGM 중 랜덤으로 재생
  - [재생], [정지], [다음] 버튼 제공
  - 이미 재생 중인 경우 [재생] 버튼은 무효 처리됨
  - [다음] 버튼은 이전 곡을 제외한 새로운 곡 랜덤 재생

- **감성적인 UI**
  - 이미지 중심의 따뜻한 화면 구성
  - 버튼과 라벨 모두 corner radius 적용
  - 어두운 배경 + 모달형 DatePicker로 몰입도 있는 사용자 경험

<br/>

## 🛠 기술 스택

- **언어**: Swift
- **프레임워크**: UIKit, AVFoundation
- **지원 OS**: iOS 14 이상
- **Xcode 버전**: 15.x

<br/>

## 🎵 BGM 목록

- song1.mp3  
- song2.mp3  
- song3.mp3  
- song4.mp3  
- song5.mp3  

모두 로컬 번들 리소스로 포함되어 있으며, 무작위로 재생됩니다.

<br/>

## 📸 실행 화면

<table>
  <tr>
    <th style="text-align:center;">메인 화면</th>
    <th style="text-align:center;">날짜 설정 후 화면</th>
  </tr>
  <tr>
    <td align="center">
      <div style="background-color:#f5f5f5; padding:10px; border-radius:12px; display:inline-block;">
        <img src="https://github.com/user-attachments/assets/d2c87ec5-c9a4-4f7a-a63b-82c5bd2f7eb8" width="250" style="border-radius:12px;" />
      </div>
    </td>
    <td align="center">
      <div style="background-color:#f5f5f5; padding:10px; border-radius:12px; display:inline-block;">
        <img src="https://github.com/user-attachments/assets/68773612-80af-4f46-a634-e5890bea91ed" width="250" style="border-radius:12px;" />
      </div>
    </td>
  </tr>
</table>

