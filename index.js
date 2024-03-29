import {NativeEventEmitter, NativeModules} from 'react-native';
import VideosApi from './videos';
import AudiosApi from './audios';
import ImagesApi from './images';
import ZiggeoVideoView from './video_view.js';
import ZiggeoCameraView from './camera_view.js';

const {ZiggeoPlayer} = NativeModules;
const {ZiggeoRecorder} = NativeModules;

const {Videos} = NativeModules;
const {Audios} = NativeModules;
const {Images} = NativeModules;
const {ContactUs} = NativeModules;

export default {
    VideosApi,
    AudiosApi,
    ImagesApi,
    // Common
    setAppToken: function (appToken: string) {
        ZiggeoPlayer.setAppToken(appToken);
        ZiggeoRecorder.setAppToken(appToken);
        Videos.setAppToken(appToken);
        Audios.setAppToken(appToken);
        Images.setAppToken(appToken);
        ContactUs.setAppToken(appToken);
    },
    setClientAuthToken: function (token: string) {
        ZiggeoPlayer.setClientAuthToken(token);
        ZiggeoRecorder.setClientAuthToken(token);
        Videos.setClientAuthToken(token);
        Audios.setClientAuthToken(token);
        Images.setClientAuthToken(token);
        ContactUs.setClientAuthToken(token);
    },
    setServerAuthToken: function (token: string) {
        ZiggeoPlayer.setServerAuthToken(token);
        ZiggeoRecorder.setServerAuthToken(token);
        Videos.setServerAuthToken(token);
        Audios.setServerAuthToken(token);
        Images.setServerAuthToken(token);
        ContactUs.setServerAuthToken(token);
    },
    sendReport(logsList) {
        ContactUs.sendReport(logsList);
    },
    sendEmailToSupport() {
        ContactUs.sendEmailToSupport();
    },
    setSensorManager: function (map) {
        ZiggeoRecorder.setSensorManager(map);
    },

    // ZiggeoRecorder
    setRecorderCacheConfig: function (map) {
        ZiggeoRecorder.setRecorderCacheConfig(map);
    },     
    setUploadingConfig: function (map) {
        ZiggeoRecorder.setUploadingConfig(map);
    },
    setLiveStreamingEnabled: function (enabled) {
        ZiggeoRecorder.setLiveStreamingEnabled(enabled);
    },
    setAutostartRecordingAfter: function (seconds) {
        ZiggeoRecorder.setAutostartRecordingAfter(seconds);
    },
    setStartDelay: function (seconds) {
        ZiggeoRecorder.setStartDelay(seconds);
    },
    /**
     * @deprecated Use `setExtraArgsForRecorder` instead.
     */
    setExtraArgsForCreateVideo: function (map) {
        console.warn('Calling deprecated function!');
        ZiggeoRecorder.setExtraArgsForCreateVideo(map);
    },
    setExtraArgsForRecorder: function (map) {
        ZiggeoRecorder.setExtraArgsForRecorder(map);
    },
    setThemeArgsForRecorder: function (map) {
        ZiggeoRecorder.setThemeArgsForRecorder(map);
    },
    setCoverSelectorEnabled: function (enabled) {
        ZiggeoRecorder.setCoverSelectorEnabled(enabled);
    },
    setMaxRecordingDuration: function (seconds) {
        ZiggeoRecorder.setMaxRecordingDuration(seconds);
    },
    setVideoWidth: function (videoWidth) {
        ZiggeoRecorder.setVideoWidth(videoWidth);
    },
    setVideoHeight: function (videoHeight) {
        ZiggeoRecorder.setVideoHeight(videoHeight);
    },
    setVideoBitrate: function (videoBitrate) {
        ZiggeoRecorder.setVideoBitrate(videoBitrate);
    },
    setBlurMode: function (blurMode) {
        ZiggeoRecorder.setBlurMode(blurMode);
    },
    setPausableMode: function (pausableMode) {
        ZiggeoRecorder.setPausableMode(pausableMode);
    },
    setAudioSampleRate: function (audioSampleRate) {
        ZiggeoRecorder.setAudioSampleRate(audioSampleRate);
    },
    setAudioBitrate: function (audioBitrate) {
        ZiggeoRecorder.setAudioBitrate(audioBitrate);
    },
    setCameraSwitchEnabled: function (enabled) {
        ZiggeoRecorder.setCameraSwitchEnabled(enabled);
    },
    setSendImmediately: function (sendImmediately) {
        ZiggeoRecorder.setSendImmediately(sendImmediately);
    },
    setQuality: function (quality) {
        ZiggeoRecorder.setQuality(quality);
    },
    setCamera: function (camera) {
        ZiggeoRecorder.setCamera(camera);
    },
    setStopRecordingConfirmationDialogConfig: function (config) {
        ZiggeoRecorder.setStopRecordingConfirmationDialogConfig(config);
    },
    /**
     * @deprecated Use `startCameraRecorder()` instead.
     */
    record: async function () {
        return ZiggeoRecorder.record();
    },
    startCameraRecorder: async function () {
        return ZiggeoRecorder.record();
    },
    startImageRecorder: async function () {
        return ZiggeoRecorder.startImageRecorder();
    },
    startAudioRecorder: async function () {
        return ZiggeoRecorder.startAudioRecorder();
    },
    startAudioPlayer: async function (...token: string) {
        return ZiggeoRecorder.startAudioPlayer(token);
    },
    showImage: async function (...token: string) {
        return ZiggeoRecorder.showImage(token);
    },
    /**
     * New added function
     */
    trimVideo: async function(videoUrl: string) {
        ZiggeoRecorder.trimVideo(videoUrl);
    },
    playAudio: async function (token: string) {
        ZiggeoRecorder.playAudio(token);
    },
    playAudios: async function (token: string[]) {
        ZiggeoRecorder.playAudios(token);
    },
    showImages: async function (tokens: string[]) {
        ZiggeoRecorder.showImages(tokens);
    },
    playVideos: function (tokens: string[]) {
        ZiggeoPlayer.playVideos(tokens);
    },
    playFromUris: function (urls: string[]) {
        ZiggeoPlayer.playFromUris(urls);
    },
    /***********************/
    startScreenRecorder: async function (appGroup, preferredExtension) {
        return ZiggeoRecorder.startScreenRecorder(appGroup, preferredExtension);
    },
    uploadFromPath: async function (fileName, createObject: CreateObject) {
        return ZiggeoRecorder.uploadFromPath(fileName, createObject);
    },
    uploadFromFileSelector: async function (argsMap) {
        return ZiggeoRecorder.uploadFromFileSelector(argsMap);
    },
    startQrScanner: function (data) {
        ZiggeoRecorder.startQrScanner(data);
    },
    recorderEmitter: function () {
        return new NativeEventEmitter(ZiggeoRecorder);
    },
    cameraViewEmitter: function () {
        return new NativeEventEmitter(ZiggeoCameraView);
    },
    videoViewEmitter: function () {
        return new NativeEventEmitter(ZiggeoVideoView);
    },

    // Video Player
    playVideo: function (...videoId: string) {
        ZiggeoPlayer.playVideo(videoId);
    },
    playFromUri: function (...path_or_url: string) {
        ZiggeoPlayer.playFromUri(path_or_url);
    },
    setExtraArgsForPlayer: function (map) {
        ZiggeoPlayer.setExtraArgsForPlayer(map);
    },
    setThemeArgsForPlayer: function (map) {
        ZiggeoPlayer.setThemeArgsForPlayer(map);
    },
    setAdsURL: function (url) {
        ZiggeoPlayer.setAdsURL(url);
    },
    cancelCurrentUpload: function (delete_file: boolean) {
        ZiggeoRecorder.cancelCurrentUpload(delete_file);
    },
    cancelUploadByPath: function (path: string, delete_file: boolean) {
        ZiggeoRecorder.cancelUploadByPath(path, delete_file);
    },

    getAppToken: function () {
        return ZiggeoPlayer.getAppToken();
    },
    getClientAuthToken: function () {
        return ZiggeoPlayer.getClientAuthToken();
    },
    getServerAuthToken: function () {
        return ZiggeoPlayer.getServerAuthToken();
    },
    getAdsURL: function () {
        return ZiggeoPlayer.getAdsURL();
    },
    getThemeArgsForPlayer: function () {
        return ZiggeoPlayer.getThemeArgsForPlayer();
    },

    getStopRecordingConfirmationDialogConfig: function () {
        return ZiggeoRecorder.getStopRecordingConfirmationDialogConfig();
    },
    getBlurMode: function () {
        return ZiggeoRecorder.getBlurMode();
    },
    getPausableMode: function() {
        return  ZiggeoRecorder.getPausableMode();
    },
    getVideoWidth: function () {
        return ZiggeoRecorder.getVideoWidth();
    },
    getVideoBitrate: function () {
        return ZiggeoRecorder.getVideoBitrate();
    },
    getAudioSampleRate: function () {
        return ZiggeoRecorder.getAudioSampleRate();
    },
    getAudioBitrate: function () {
        return ZiggeoRecorder.getAudioBitrate();
    },
    getVideoHeight: function () {
        return ZiggeoRecorder.getVideoHeight();
    },
    getLiveStreamingEnabled: function () {
        return ZiggeoRecorder.getLiveStreamingEnabled();
    },
    getAutostartRecording: function () {
        return ZiggeoRecorder.getAutostartRecording();
    },
    getStartDelay: function () {
        return ZiggeoRecorder.getStartDelay();
    },
    getExtraArgsForRecorder: function () {
        return ZiggeoRecorder.getExtraArgsForRecorder();
    },
    getCoverSelectorEnabled: function (){
        return ZiggeoRecorder.getCoverSelectorEnabled();
    },
    getMaxRecordingDuration: function () {
        return ZiggeoRecorder.getMaxRecordingDuration();
    },
    getCameraSwitchEnabled: function () {
        return ZiggeoRecorder.getCameraSwitchEnabled();
    },
    getSendImmediately: function () {
        return ZiggeoRecorder.getSendImmediately();
    },
    getCamera: function () {
        return ZiggeoRecorder.getCamera();
    },
    getQuality: function () {
        return ZiggeoRecorder.getQuality();
    },
    getRecorderCacheConfig: function () {
        return ZiggeoRecorder.getRecorderCacheConfig();
    },
    getUploadingConfig: function () {
        return ZiggeoRecorder.getUploadingConfig();
    },

    // Constants
    REAR_CAMERA: ZiggeoRecorder.rearCamera,
    FRONT_CAMERA: ZiggeoRecorder.frontCamera,
    HIGH_QUALITY: ZiggeoRecorder.highQuality,
    MEDIUM_QUALITY: ZiggeoRecorder.mediumQuality,
    LOW_QUALITY: ZiggeoRecorder.lowQuality,

    MEDIA_TYPE_VIDEO: ZiggeoRecorder.video,
    MEDIA_TYPE_AUDIO: ZiggeoRecorder.audio,
    MEDIA_TYPE_IMAGE: ZiggeoRecorder.image,

    UPLOADING_ERROR_ACTION_DELETE_MEDIA: 554,
    UPLOADING_ERROR_ACTION_ERROR_NOTIFICATION: 553,
    UPLOADING_ERROR_ACTION_RELOAD_MEDIA: 552,
    UPLOADING_ERROR_ACTION_CONTINUE_UPLOADING_MEDIA: 551,
};
