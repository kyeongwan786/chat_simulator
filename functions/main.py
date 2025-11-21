from firebase_functions import https_fn
import json

@https_fn.on_request()
def test_hello_world(req: https_fn.Request) -> https_fn.Response:
    return https_fn.Response(
        json.dumps({"message": "Hello from Firebase Python Functions!"}),
        status=200,
        headers={"Content-Type": "application/json"},
    )
