[WIP]
# Preparing an ESP32 product for the IoT World

We have learned through multiple iterative development cycles, that one of the most important qualities for a product is scalability and as for a designer, envisioning the product a couple of months or years down the road depending on their predicted growth is of paramount importance. If you are confident in your product, you will surely have to think about building it towards the impact you want it to create, and do so right from the start. Failure to do this could impact sales, quality and in many cases, failure of a product that was otherwise splendid!

One of the things that needs due consideration is flashing the devices with firmware during manufacturing. Now that you did everything right, and you're shipping thousands of units every day, to make this manufacturing process significantly more efficient, saving time and effort becomes a key ingredient to higher sales and hence contributing to even higher success of the product. That is why this particular time, I will talk about automating flashing/burning firmware into your products while saving time and effort with an example on the colossal ESP32.

Espressif has given us the [esptool](https://github.com/espressif/esptool) utility to take care of multiple such needs required in order to scale our manufacturing. It is a python-based, open-source utility that can be used to communicate with the ESP32 bootloader. For details, visit esptool [repo](https://github.com/espressif/esptool). 

## Need for a unique identifier while flashing firmware
We know that when deploying a fleet of multiple devices, nomenclature of these devices are of the essence for various obvious reasons:
- Identification
- Grouping
- Analysis, etc.

More often than not, we might find ourselves in a need to use these identifiers before the devices are deployed to the "field". For ESP32s, we use the unique 12-digit default MAC address as `device_id`/`thing name` of the device for:
- Registering them on the cloud
- Adding/embedding certificates and keys for security

What are IoT devices incomplete without? Yep, data collection. Where do you send this data? To your data observers on the internet. How does our data observers know what data comes from which device? You guessed it! The devices need to be pre-registered. One more vitally important reason to pre-register these devices is security and verification. How do you stop an unknown device from sniffing your data? By restricting the connectivity to a group of pre-registered devices. Okay, lets slow down and see what I'm talking about in a little more details.

Let's look at an example scenario using AWS IoT Core since [AWS accounted for a third of $42 billion cloud market in Q1 2021](https://telecoms.com/509588/aws-accounted-for-a-third-of-42-billion-cloud-market-in-q1-2021/). Here's a quick get-started with AWS IoT Core for you:

1. Register each device as a unique "thing" on AWS IoT Core server
2. Create and attach a certificate to the thing you just created
3. Download the device certificate, private key and public key. Use them in your device to successfully SSL verify your device to the AWS IoT server.
4. Connect to AWS IoT from your device and start pushing data into the cloud!

> For more details on this, please visit https://docs.aws.amazon.com/iot/latest/developerguide/iot-gs.html

This can be done in two ways:
1. [AWS IoT Core console](https://docs.aws.amazon.com/iot/latest/developerguide/iot-moisture-create-thing.html)
2. [AWS CLI Tool](https://docs.aws.amazon.com/cli/latest/reference/iot/)
3. One of [several SDKs available](https://docs.aws.amazon.com/iot/latest/developerguide/iot-sdks.html).

We want to bring to you two ways of getting data into the AWS cloud:

### 1. Introducing [Bodh](https://bodh.iotready.co/)
Bodh takes you from sign up to dashboards in less than 2 minutes. No more hassles, only bedazzles! Take a look at the get-started video on https://bodh.iotready.co to spend two precious minutes of your time on how to get started with a cloud connected device and then take another two minutes to actually get your device sending data into the dashboard!

<p style="text-align:center;"><img src="./asset/architecture.jpg" alt="architecture" class="center" width="500" height="400" /></p>

> Bodh at https://bodh.iotready.co<br>
 Get the CLI tool at https://github.com/IoTReady/bodh_cli<br>
 Documentation at https://bodh.iotready.co/docs

### 2. Using Python SDK ([Boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html#)):
The prepare script is a tool that does the following:
1. Use esptool to get the default MAC address of the device.
2. Create a policy if it does not already exist. To learn about policies in AWS, visit [here](https://docs.aws.amazon.com/iot/latest/developerguide/iot-policies.html).
3. Create keys(private and public) and certificate for the device and save them as files.
4. Attach the existing/created policy in step2 to the certificate.
5. Create a new thing with the MAC address achieved in step1 as thing name.
6. Copy/embed the downloaded certificate and keys files into the necessary folder.

<p style="text-align:center;"><img src="./asset/prepare_flow.png" alt="prepare_flow" class="center" width="400" height="500" /></p>




