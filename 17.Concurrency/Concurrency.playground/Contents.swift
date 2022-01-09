import UIKit

//Parallel code means multiple pieces of code run simultaneously—for example, a computer with a four-core processor can run four pieces of code at the same time, with each core carrying out one of the tasks.
//The concurrency model in Swift is built on top of threads.


//concurrent code without using Swift’s language support
//Even in this simple case, because the code has to be written as a series of completion handlers, you end up writing nested closures.
listPhotosss(inGallery: "Summer Vacation") { photoNames in
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    downloadPhotooo(named: name) { photo in
        show(photo)
    }
}
func showww(_ photo: UIImage?) {}
func downloadPhotooo(named: String, _ completion: (_ photo: UIImage?)->Void) {
    completion(UIImage(named: ""))
}
func listPhotosss(inGallery: String, _ completion: (_ names: [String])->Void) {
    completion(["image1", "image2"])
}



//With Concurrency support
//For a function or method that’s both asynchronous and throwing, you write async before throws.

func listPhotos(inGallery name: String) async -> [String] {
    await Task.sleep(2 * 1_000_000_000)  // Two seconds
//    The Task.sleep(_:) method is useful when writing simple code to learn how concurrency works. This method does nothing, but waits at least the given number of nanoseconds before it returns.
    return ["IMG001", "IMG99", "IMG0404"]
}
func downloadPhoto(named: String) async -> UIImage? {
    await Task.sleep(2 * 1_000_000_000)
    return UIImage(named: "")
}
func downloadPhotoo(named: String) async -> Data {
    await Task.sleep(2 * 1_000_000_000)
    return Data.init()
}
func show(_ photo: UIImage?) {}
func show(_ photos: [UIImage?]) {}


//"await listPhotos" must be called from an async context.
Task {
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    let photo = await downloadPhoto(named: name)
    show(photo)
    
    //Calling Asynchronous Functions in Parallel
    let firstPhoto = await downloadPhoto(named: photoNames[0])
    let secondPhoto = await downloadPhoto(named: photoNames[1])
    let thirdPhoto = await downloadPhoto(named: photoNames[2])

    let photos = [firstPhoto, secondPhoto, thirdPhoto]
    show(photos)
    //This approach has an important drawback: Although the download is asynchronous and lets other work happen while it progresses, only one call to downloadPhoto(named:) runs at a time.
    
    
//    To call an asynchronous function and let it run in parallel with code around it, write async in front of let when you define a constant, and then write await each time you use the constant.
    async let firstPhotoo = downloadPhoto(named: photoNames[0])
    async let secondPhotoo = downloadPhoto(named: photoNames[1])
    async let thirdPhotoo = downloadPhoto(named: photoNames[2])

    let photoss = await [firstPhotoo, secondPhotoo, thirdPhotoo]
    show(photoss)
    
    
//    Tasks and Task Groups
//https://developer.apple.com/documentation/swift/taskgroup
    await withTaskGroup(of: Data.self) { taskGroup in
        let photoNames = await listPhotos(inGallery: "Summer Vacation")
        for name in photoNames {
            taskGroup.addTask { await downloadPhotoo(named: name) }
        }
    }
    
//    Unstructured Concurrency
//    let newPhoto = // ... some photo data ...
//    let handle = Task {
//        return await add(newPhoto, toGalleryNamed: "Spring Adventures")
//    }
//    let result = await handle.value
    
    
    
//    To check for cancellation, either call Task.checkCancellation(), which throws CancellationError if the task has been canceled, or check the value of Task.isCancelled and handle the cancellation in your own code. For example, a task that’s downloading photos from a gallery might need to delete partial downloads and close network connections.
//
//    To propagate cancellation manually, call Task.cancel().
    
}


//Actors
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}


extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}

let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
Task {
    print(await logger.max)
    // Prints "25"
    print(logger.label)
    print(await logger.measurements)
//    print(logger.measurements) // Error
//    print(logger.max)  // Error
}

//Task {
//    await withTaskGroup(of: UIImage.self) { groupTask in
//
//    }
//}

