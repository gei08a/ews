import socket, httplib, urllib, urllib2
import xml.etree.ElementTree as etree
import time

class Session:
    def __init__(self, license_key):
        self.__license_key = license_key
        self.__sms_action_url = "http://sms2.cdyne.com/sms.svc"
        self.__max_retries = 1


    def __xml_to_dictionary(self, xml):
        boolean_keys = ["Queued", "SMSIncomingMessages", "Sent", "Cancelled"]
        if type(xml) != etree.Element:
            root = etree.XML(xml)
        else:
            root = xml
        dictionary = {}
        if root is not None:
            for element in root.getchildren():
                element_name = element.tag.split("}")[1]
                element_value = element.text
                if element_name in boolean_keys:
                    if element_value == "true":
                        element_value = True
                    else:
                        element_value = False
                dictionary[element_name] = element_value
        return dictionary


    def __get_request(self, request):
        """
        Return contents of a given request
        """
        for i in range(0, self.__max_retries):
            try:
                return urllib2.urlopen(request).read()
            except urllib2.URLError:
                time.sleep(3)
            except httplib.BadStatusLine or httplib.InvalidURL:
                time.sleep(3)
            except socket.error or socket.timeout:
                time.sleep(3)
            except:
                import traceback
                traceback.print_exc()
        raise NameError("Failed to grab URL: %s", request)


    def __send_request(self, data, function):
        request_url = self.__sms_action_url + "/%s" % function
        request_url += "?%s" % urllib.urlencode(data)
        response = self.__get_request(request_url)
        return self.__xml_to_dictionary(response)


    def send_sms(self, phone_number, message):
        data = {"PhoneNumber": phone_number,
                "LicenseKey": self.__license_key,
                "Message": message}
        return self.__send_request(data, "SimpleSMSSend")

## Send a message
#phone_number = "2142268346"
#message = "This is a test message from CDYNE"
#print sms.simple_sms_send(phone_number, message)
