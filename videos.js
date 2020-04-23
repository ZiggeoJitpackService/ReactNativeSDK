import { NativeModules, NativeEventEmitter, requireNativeComponent } from 'react-native';

const { Videos } = NativeModules;

export default {

	index: async function (map) {
		return Videos.index(map);
	},
	getImageUrl: async function (tokenOrKey: string) {
		return Videos.getImageUrl(tokenOrKey);
	},

	downloadImage: async function (tokenOrKey) {
		return Videos.downloadImage(tokenOrKey);
	},

 };
