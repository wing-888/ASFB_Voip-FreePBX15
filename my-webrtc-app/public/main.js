let divSelectRoom = document.getElementById("selectRoom")
let divConsultingRoom = document.getElementById("consultingRoom")
let inputRoomNumber = document.getElementById("roomNumber")
let btnGoRoom = document.getElementById("goRoom")
let localVideo = document.getElementById("localVideo")
let remoteVideo = document.getElementById("remoteVideo")

let roomNumber, localStream, remoteStream, rtcPeerConnection, isCaller

const iceServers = {
    'iceServers': [
        {'urls' : 'stun:stun.services.mozilla.com'},
        {'urls' : 'stun:stun.l.google.com:19302'},
    ]
}

const streamConstraints = {
    audio: true,
    video: {
        width: { min: 1280 },
        height: { min: 720 }
      }
}

btnGoRoom.onclick = () => {
    if(inputRoomNumber.value === '') {
        alert("Vui lòng nhập tên phòng")
    } else {
        navigator.mediaDevices.getUserMedia(streamConstraints) 
            .then(stream => {
                localStream = stream
                localVideo.srcObject = stream
            })
            .catch(err => {
                console.log('Đã xảy ra lỗi gì đó....', err)
            })
        divSelectRoom.style = "display: none"
        divConsultingRoom.style = "display: block"
    }
}