// this sets the background color of the master UIView (when there are no windows/tab groups on it)
Titanium.UI.setBackgroundColor('#000');

var win = Ti.UI.createWindow();

var tracker = require('com.bongole.ti.ga');
tracker.start({trackingId: 'YOUR TRACKING CODE', dryRun: true, verbose: true});

win.addEventListener('open', function(){
    tracker.trackScreen({screenName: 'MyScreen'});
});

var btn = Ti.UI.createButton({
    title: 'CLICK'
});

btn.addEventListener('click', function(){
    tracker.trackEvent({screenName: 'MyScreen', category: 'mycat', action: 'myaction'});
});

win.add(btn);

win.open();
