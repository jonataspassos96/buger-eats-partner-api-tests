*** Settings ***
Documentation       RabbitMQ Helpers API

Library             ../.venv/lib/python3.9/site-packages/RequestsLibrary/__init__.py


*** Variables ***
${RABBIT_URL}           https://hornet.rmq.cloudmqp.com/api/queues/tltftkga/email
&{RABBIT_HEADERS}
...                     Content-Type=application/json
...                     Authorization=Basic 4F1GH4F32U4F213J4FKJ56FGHF98X8DFGS90FG6D0F766V34=


*** Keywords ***
Purge Messages
    ${payload}    Create Dictionary
    ...    vhost=tltftkga
    ...    name=email
    ...    mode=purge

    ${response}    DELETE
    ...    ${RABBIT_URL}/contents
    ...    json=${payload}
    ...    headers=${RABBIT_HEADERS}

    RETURN    ${response}

Get Message
    ${payload}    Create Dictionary
    ...    vhost=tltftkga
    ...    name=email
    ...    truncate=50000
    ...    ackmode=ack_requeue_true
    ...    encoding=auto
    ...    count=1

    ${response}    POST
    ...    ${RABBIT_URL}/get
    ...    json=${payload}
    ...    headers=${RABBIT_HEADERS}

    RETURN    ${response.json()}[0]
