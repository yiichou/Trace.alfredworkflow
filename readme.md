# Trace (Proxy-helper).alfredworkflow

在 Mac 上切换代理是一件麻烦的事情，然而不幸的是一旦你有了这个需求往往也意味着你需要频繁进行这个操作

于是我造了这个偷懒用的 alfredworkflow

希望有人能用得着

### Quickly start

1. Download
    
    https://github.com/IvanChou/Trace.alfredworkflow/raw/master/Trace%20(Proxy-helper).alfredworkflow
    
2. Setting
    
    - Doubule click `trace` in Alfred Workflows Preferences
    - Click `Open workflow folder` to open Finder
    - Open `proxy.conf` and modify like sample

3. Use
    
    Call out your alfred, and type `trace`
    
    ![](http://ww4.sinaimg.cn/mw690/006pIUL1gw1f69r4xsjf0j30g10790tq.jpg)
    
4. Enjoy it!

### More feature

When you change your proxy setting via Trace, OSX may ask your password to allow this operation everytime. There is no better way to slove the question, but let trace keep your password.

Open `trace.sh` , set your password

```bash
# set your password, avoid to be asked every time.
PWD='yourpwd'
```
It's unsafe, but quite convenient. By the way, if nobody has been told, is there anyone know your password has been shown here?

### About Trace

It's inspired by Fate.  "Trace on!"