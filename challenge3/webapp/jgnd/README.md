Requirements
---

Python 2.7 (untested on Python 3)

Setup
---

This is a Django app so run the following commands to setup the (sqlite) DB:

```python manage.py migrate```


```python manage.py migrate dashboard 0001```


```python manage.py populate_db``` (this will erase DB contents and replace them with the CSV data)


To run the server:

```python manage.py runserver```


To run the tests:

```python manage.py test```
