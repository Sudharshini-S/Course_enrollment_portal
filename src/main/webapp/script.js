function checkSessionAndSubmit(event) {
    event.preventDefault();  
    var errorDisplay = document.getElementById("ajaxErrorText");
    if (errorDisplay) {
        errorDisplay.innerHTML = ""; 
    }
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "SubscriptionServlet?action=checkSession", true);
	xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var xmlResponse = xhr.responseXML;            
            if (xmlResponse) {
                var statusElements = xmlResponse.getElementsByTagName("status");
                var messageElements = xmlResponse.getElementsByTagName("message");              
                if (statusElements.length > 0 && messageElements.length > 0) {
                    var status = statusElements[0].textContent || statusElements[0].text;
                    var message = messageElements[0].textContent || messageElements[0].text;
                    if (status === "authorized") {
                        document.getElementById("subscriptionForm").submit();
                    } 
					else {
                        if (errorDisplay) {
                            errorDisplay.innerHTML = message;
                        }
                    }
                }
            }
        }
    };
    xhr.send();
}
