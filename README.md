#iOS Love Meetup App Demo
This application was made as a Demo for the [iOS Love meetup](http://meetup.com/ioslove), you can watch [the presentation](https://www.youtube.com/watch?v=51iytwHtnHQ), its references and many other presentations at our [Youtube Channel](https://www.youtube.com/c/iOSLove)

## How to run it

Yes, I'm still using Cocoapods.

**1.** Install the dependencies by running the following command: 

```
pod install
```

Once it finishes, open the `iOSLove.xcworkspace`.

**2.** Get your own Meetup's API Key

[Meetup.com - Getting an API Key](https://secure.meetup.com/meetup_api/key/)

**3.** Go to ***Edit Scheme...***. 

You can get there by clicking the target (at the top left corner), or by using the main menu *Product/Scheme/Edit Scheme...*

![Image 1]()

**4.** Create a new ***Environment Variable*** named

```
MEETUP_API_KEY
```

And set your API Key as the value.

![Image 2]()

And then you should be ready to go... hopefully


