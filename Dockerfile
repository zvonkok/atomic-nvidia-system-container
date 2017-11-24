FROM    rhel7-atomic
        
RUN     rpm-ostree install kernel-devel-3.10.0-693.el7.x86_64
RUN     rpm-ostree install rpm-ostree install gcc-4.8.5-16.el7.x86_64
RUN     rpm-ostree ex livefs
