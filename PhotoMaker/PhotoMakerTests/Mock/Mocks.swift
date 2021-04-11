//
//  Mocks.swift
//  PhotoMakerTests
//
//  Created by Georgy Fesenko on 4/11/21.
//

@testable import PhotoMaker
import UIKit

class HomeFlowProtocolMock: HomeFlowProtocol {

    //MARK: - presentCamera

    var presentCameraCallsCount = 0
    var presentCameraCalled: Bool {
        return presentCameraCallsCount > 0
    }
    var presentCameraClosure: (() -> Void)?

    func presentCamera() {
        presentCameraCallsCount += 1
        presentCameraClosure?()
    }

    //MARK: - presentPhotoList

    var presentPhotoListCallsCount = 0
    var presentPhotoListCalled: Bool {
        return presentPhotoListCallsCount > 0
    }
    var presentPhotoListClosure: (() -> Void)?

    func presentPhotoList() {
        presentPhotoListCallsCount += 1
        presentPhotoListClosure?()
    }

    //MARK: - presentPhotoPreview

    var presentPhotoPreviewImageCreationDateCallsCount = 0
    var presentPhotoPreviewImageCreationDateCalled: Bool {
        return presentPhotoPreviewImageCreationDateCallsCount > 0
    }
    var presentPhotoPreviewImageCreationDateReceivedArguments: (image: UIImage, creationDate: Date)?
    var presentPhotoPreviewImageCreationDateReceivedInvocations: [(image: UIImage, creationDate: Date)] = []
    var presentPhotoPreviewImageCreationDateClosure: ((UIImage, Date) -> Void)?

    func presentPhotoPreview(image: UIImage, creationDate: Date) {
        presentPhotoPreviewImageCreationDateCallsCount += 1
        presentPhotoPreviewImageCreationDateReceivedArguments = (image: image, creationDate: creationDate)
        presentPhotoPreviewImageCreationDateReceivedInvocations.append((image: image, creationDate: creationDate))
        presentPhotoPreviewImageCreationDateClosure?(image, creationDate)
    }

    //MARK: - presentPhotoView

    var presentPhotoViewImageCallsCount = 0
    var presentPhotoViewImageCalled: Bool {
        return presentPhotoViewImageCallsCount > 0
    }
    var presentPhotoViewImageReceivedImage: UIImage?
    var presentPhotoViewImageReceivedInvocations: [UIImage] = []
    var presentPhotoViewImageClosure: ((UIImage) -> Void)?

    func presentPhotoView(image: UIImage) {
        presentPhotoViewImageCallsCount += 1
        presentPhotoViewImageReceivedImage = image
        presentPhotoViewImageReceivedInvocations.append(image)
        presentPhotoViewImageClosure?(image)
    }

}
class PermissionsManagerProtocolMock: PermissionsManagerProtocol {

    //MARK: - verifyCameraPermissions

    var verifyCameraPermissionsOnSuccessCallsCount = 0
    var verifyCameraPermissionsOnSuccessCalled: Bool {
        return verifyCameraPermissionsOnSuccessCallsCount > 0
    }
    var verifyCameraPermissionsOnSuccessReceivedOnSuccess: (() -> Void)?
    var verifyCameraPermissionsOnSuccessReceivedInvocations: [(() -> Void)] = []
    var verifyCameraPermissionsOnSuccessClosure: ((@escaping () -> Void) -> Void)?

    func verifyCameraPermissions(onSuccess: @escaping () -> Void) {
        verifyCameraPermissionsOnSuccessCallsCount += 1
        verifyCameraPermissionsOnSuccessReceivedOnSuccess = onSuccess
        verifyCameraPermissionsOnSuccessReceivedInvocations.append(onSuccess)
        verifyCameraPermissionsOnSuccessClosure?(onSuccess)
    }

}
class PhotosRepositoryProtocolMock: PhotosRepositoryProtocol {

    //MARK: - storeImage

    var storeImageImageCallsCount = 0
    var storeImageImageCalled: Bool {
        return storeImageImageCallsCount > 0
    }
    var storeImageImageReceivedImage: Image?
    var storeImageImageReceivedInvocations: [Image] = []
    var storeImageImageClosure: ((Image) -> Void)?

    func storeImage(image: Image) {
        storeImageImageCallsCount += 1
        storeImageImageReceivedImage = image
        storeImageImageReceivedInvocations.append(image)
        storeImageImageClosure?(image)
    }

    //MARK: - getImages

    var getImagesCallsCount = 0
    var getImagesCalled: Bool {
        return getImagesCallsCount > 0
    }
    var getImagesReturnValue: [Image]!
    var getImagesClosure: (() -> [Image])?

    func getImages() -> [Image] {
        getImagesCallsCount += 1
        return getImagesClosure.map({ $0() }) ?? getImagesReturnValue
    }

}
class ScreenFactoryProtocolMock: ScreenFactoryProtocol {

    //MARK: - makeHomeScreen

    var makeHomeScreenNavigationControllerCallsCount = 0
    var makeHomeScreenNavigationControllerCalled: Bool {
        return makeHomeScreenNavigationControllerCallsCount > 0
    }
    var makeHomeScreenNavigationControllerReceivedNavigationController: UINavigationController?
    var makeHomeScreenNavigationControllerReceivedInvocations: [UINavigationController] = []
    var makeHomeScreenNavigationControllerReturnValue: UIViewController!
    var makeHomeScreenNavigationControllerClosure: ((UINavigationController) -> UIViewController)?

    func makeHomeScreen(navigationController: UINavigationController) -> UIViewController {
        makeHomeScreenNavigationControllerCallsCount += 1
        makeHomeScreenNavigationControllerReceivedNavigationController = navigationController
        makeHomeScreenNavigationControllerReceivedInvocations.append(navigationController)
        return makeHomeScreenNavigationControllerClosure.map({ $0(navigationController) }) ?? makeHomeScreenNavigationControllerReturnValue
    }

    //MARK: - makePhotosListScreen

    var makePhotosListScreenFlowCallsCount = 0
    var makePhotosListScreenFlowCalled: Bool {
        return makePhotosListScreenFlowCallsCount > 0
    }
    var makePhotosListScreenFlowReceivedFlow: HomeFlow?
    var makePhotosListScreenFlowReceivedInvocations: [HomeFlow] = []
    var makePhotosListScreenFlowReturnValue: UIViewController!
    var makePhotosListScreenFlowClosure: ((HomeFlow) -> UIViewController)?

    func makePhotosListScreen(flow: HomeFlow) -> UIViewController {
        makePhotosListScreenFlowCallsCount += 1
        makePhotosListScreenFlowReceivedFlow = flow
        makePhotosListScreenFlowReceivedInvocations.append(flow)
        return makePhotosListScreenFlowClosure.map({ $0(flow) }) ?? makePhotosListScreenFlowReturnValue
    }

    //MARK: - makeSavePhotoAlert

    var makeSavePhotoAlertCompletionCallsCount = 0
    var makeSavePhotoAlertCompletionCalled: Bool {
        return makeSavePhotoAlertCompletionCallsCount > 0
    }
    var makeSavePhotoAlertCompletionReceivedCompletion: ((String) -> Void)?
    var makeSavePhotoAlertCompletionReceivedInvocations: [((String) -> Void)] = []
    var makeSavePhotoAlertCompletionReturnValue: UIViewController!
    var makeSavePhotoAlertCompletionClosure: ((@escaping (String) -> Void) -> UIViewController)?

    func makeSavePhotoAlert(completion: @escaping (String) -> Void) -> UIViewController {
        makeSavePhotoAlertCompletionCallsCount += 1
        makeSavePhotoAlertCompletionReceivedCompletion = completion
        makeSavePhotoAlertCompletionReceivedInvocations.append(completion)
        return makeSavePhotoAlertCompletionClosure.map({ $0(completion) }) ?? makeSavePhotoAlertCompletionReturnValue
    }

    //MARK: - makePhotoFullScreen

    var makePhotoFullScreenImageCallsCount = 0
    var makePhotoFullScreenImageCalled: Bool {
        return makePhotoFullScreenImageCallsCount > 0
    }
    var makePhotoFullScreenImageReceivedImage: UIImage?
    var makePhotoFullScreenImageReceivedInvocations: [UIImage] = []
    var makePhotoFullScreenImageReturnValue: UIViewController!
    var makePhotoFullScreenImageClosure: ((UIImage) -> UIViewController)?

    func makePhotoFullScreen(image: UIImage) -> UIViewController {
        makePhotoFullScreenImageCallsCount += 1
        makePhotoFullScreenImageReceivedImage = image
        makePhotoFullScreenImageReceivedInvocations.append(image)
        return makePhotoFullScreenImageClosure.map({ $0(image) }) ?? makePhotoFullScreenImageReturnValue
    }

}
