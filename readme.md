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

When you change your proxy setting via Trace, OSX may ask your password to allow this operation everytime. 

To slove this question, you can do something more:

1. add the following line to `/etc/sudoers/`
    
    ```
    yourusername ALL=NOPASSWD: /usr/sbin/networksetup 
    # e.g.
    IChou ALL=NOPASSWD: /usr/sbin/networksetup
    ```
    > Remeber the file `/etc/sudoers/` must end with a empty line!!
    
2. re-link the scripts of trace
    
    ![](http://ww4.sinaimg.cn/large/006pIUL1gw1f6c4lm9l0qj30kh07o75b.jpg)

### About Trace

It's inspired by Fate.  "Trace on!"