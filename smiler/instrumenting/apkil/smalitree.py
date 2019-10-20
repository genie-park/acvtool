import os
import copy
import sys
import shutil
from io import StringIO
import smiler.instrumenting.apkil.classnode  as classnode
from smiler.instrumenting.apkil.logger import log

class SmaliTree(object):

    def __init__(self, foldernames):
        self.smali_files = []
        self.classes = []

        self.__parse(foldernames)


#TDDO:; change folder name to appropriate method
    def __repr__(self):
        return "Foldername: %s\n%s" % \
                (self.foldername, \
                "".join([repr(class_) for class_ in self.classes]))


    def _is_exluded(self, path, folder_name) :
        classes= path.replace(folder_name.strip(), '').split('\\')
        if classes[0] == '':
            classes = classes[1:]
        class_name = '.'.join(classes)

        if len(classes) == 0: return False
        if len(classes) == 1: return True
        if classes[0] in ['java', 'javax', 'sun', 'dalvik', 'android', 'org', 'kotlin', 'libcore', 'androidx',
                          'kotlinx']: return True
        if class_name.find('com.android.') == 0: return True
        if class_name.find('com.google.') == 0: return True
        if class_name.find("de.robv.android.xposed") == 0: return True
        return False

    def __parse(self, foldernames):
        for foldername in foldernames:
            print("parsing %s..." % foldername)
            for (path, dirs, files) in os.walk(foldername):
                ''''''
                # ToDo: exclude specific function need consideration for exact copy
                # if self._is_exluded(path, foldername):
                #     continue
                ''''''
                for f in files:
                    name = os.path.join(path, f)
                    rel_path = os.path.relpath(name, foldername)
                    if rel_path.find("annotation") == 0:
                        continue
                    ext = os.path.splitext(name)[1]
                    if ext != '.smali': continue
                    self.smali_files.append(name)
                    folder, fn = os.path.split(rel_path)
                    self.classes.append(classnode.ClassNode(filename=name, folder=folder))
            log("SmaliTree parsed!")

    def get_class(self, class_name):
        result = [c for c in self.classes if c.name == class_name]
        if result:
            return result[0]
        else:
            return None
    
    def add_class(self, class_node):
        if [c for c in self.classes if c.name == class_node.name]:
            print("Class %s alreasy exsits!" % class_node.name)
            return False
        else:
            self.classes.append(copy.deepcopy(class_node))
            return True

    def remove_class(self, class_node):
        # self.classes.del()
        pass

    def save(self, new_foldername):
        print("Saving %s..." % new_foldername)
        if os.path.exists(new_foldername):
            shutil.rmtree(new_foldername)
        os.makedirs(new_foldername)
        for c in self.classes:
            c.save(new_foldername)
