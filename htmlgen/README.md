# htmlgen.sh

`htmlgen.sh` is a tool for generating indexed and sorted HTML files for videos using `video.js`. Its mainly used for organizing lecture videos in my computer.

## Warnings

Launching the tool without using `-f` is **EXPERIMENTAL and NOT RECOMMENDED**.

The `-f` switch **will delete ALL HTML files in the working directory**.

## Mechanism

The tool generates an index file that contains links to generated HTML files for every folder that contains video files in the working directory. It fills these HTML files with links to HTML files that are generated for every video detected. These links are sorted into groups (depending on how the directory structure is organized) and labeled with the full path to the video file.

### Example

Let's assume that we have the following directory structure:
```
├── English
│   ├── Chapter1
│   │   ├── 1.webm
│   │   ├── 2.webm
│   │   └── 3.webm
│   └── Chapter2
│       ├── 1.webm
│       ├── 2.webm
│       └── 3.webm
├── French
│   ├── Chapter1
│   │   ├── lesson1.mp4
│   │   ├── lesson2.mp4
│   │   └── lesson3.mp4
│   └── Chapter2
│       ├── lesson1.mp4
│       ├── lesson2.mp4
│       └── lesson3.mp4
```
Running `htmlgen.sh -f` would result in this directory structory:
```
├── English
│   ├── Chapter1
│   │   ├── 1.html
│   │   ├── 1.webm
│   │   ├── 2.html
│   │   ├── 2.webm
│   │   ├── 3.html
│   │   └── 3.webm
│   └── Chapter2
│       ├── 1.html
│       ├── 1.webm
│       ├── 2.html
│       ├── 2.webm
│       ├── 3.html
│       └── 3.webm
├── English.html
├── French
│   ├── Chapter1
│   │   ├── lesson1.html
│   │   ├── lesson1.mp4
│   │   ├── lesson2.html
│   │   ├── lesson2.mp4
│   │   ├── lesson3.html
│   │   └── lesson3.mp4
│   └── Chapter2
│       ├── lesson1.html
│       ├── lesson1.mp4
│       ├── lesson2.html
│       ├── lesson2.mp4
│       ├── lesson3.html
│       └── lesson3.mp4
├── French.html
├── htmlgen.sh
├── index.html
```


`index.html` would look like this:

```
French
English 
```

`French.html` would look like this:
```
----------------------------------

1- French/Chapter1/lesson1
2- French/Chapter1/lesson2
3- French/Chapter1/lesson3

----------------------------------

1- French/Chapter2/lesson1
2- French/Chapter2/lesson2
3- French/Chapter2/lesson3 
```

`English.html` would look like this:

```

----------------------------------

1- English/Chapter1/1
2- English/Chapter1/2
3- English/Chapter1/3

----------------------------------

1- English/Chapter2/1
2- English/Chapter2/2
3- English/Chapter2/3 
```

## Limitations: 

- The script currently only supports `mp4` and `webm` videos.
- Videos with different extensions in the same folder would confuse the grouping feature in the script.
