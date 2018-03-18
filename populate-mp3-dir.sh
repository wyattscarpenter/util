# this script copies music files from the current dir to a different dir
# and re-encodes non-mp3s to be mp3s on the way

# by default, this script does not clobber, in order to save time
# if you'd like to override this behavior, remove the "-n"s from the script below
# but it would likely be more prudent to simply rm the mp3 dir beforehand

# this script might take an hour or two to run, on my computer and collection

# this script does not copy images of any kind, to save space

#TODO: learn how bash params work and make this accept an output dir param?

#copy directory structure
find . -type d -exec mkdir ../../mp3s/{} \;

#copy mp3s
find . -type f -name "*.mp3" -exec cp -n -v {} ../../mp3s/{} \;

#copy & convert non-mp3s
#it is not necessary to explicitly filter out images here
#but it does speed up the process a bit
find . -type f -not -name "*.mp3" -not -name "*.png" -not -name "*.jp*" -not -name "*.db" -not "*.log" -not ".cue" -exec ffmpeg -n -i {} -vn -q:a 0 ../../mp3s/{}.mp3 \;
