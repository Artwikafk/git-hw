# Домашнее задание к занятию "`Ansible. Часть 2`" - `Караяни Кирилл`


### Инструкция по выполнению домашнего задания

   1. Сделайте `fork` данного репозитория к себе в Github и переименуйте его по названию или номеру занятия, например, https://github.com/имя-вашего-репозитория/git-hw или  https://github.com/имя-вашего-репозитория/7-1-ansible-hw).
   2. Выполните клонирование данного репозитория к себе на ПК с помощью команды `git clone`.
   3. Выполните домашнее задание и заполните у себя локально этот файл README.md:
      - впишите вверху название занятия и вашу фамилию и имя
      - в каждом задании добавьте решение в требуемом виде (текст/код/скриншоты/ссылка)
      - для корректного добавления скриншотов воспользуйтесь [инструкцией "Как вставить скриншот в шаблон с решением](https://github.com/netology-code/sys-pattern-homework/blob/main/screen-instruction.md)
      - при оформлении используйте возможности языка разметки md (коротко об этом можно посмотреть в [инструкции  по MarkDown](https://github.com/netology-code/sys-pattern-homework/blob/main/md-instruction.md))
   4. После завершения работы над домашним заданием сделайте коммит (`git commit -m "comment"`) и отправьте его на Github (`git push origin`);
   5. В личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
   6. Любые вопросы по выполнению заданий спрашивайте в разделе “Вопросы по заданию” в личном кабинете.
   
Желаем успехов в выполнении домашнего задания!
   
### Дополнительные материалы, которые могут быть полезны для выполнения задания

1. [Руководство по оформлению Markdown файлов](https://gist.github.com/Jekins/2bf2d0638163f1294637#Code)

---

### Задание 1

`Приведите ответ в свободной форме........`

1. `cd /home/ladmin/git-hw`
2. `touch playbook1.yml #создаем файл и редактируем через VS Code`
3. `touch playbook1.yml #создаем файл и редактируем через VS Code`
4. `touch playbook1.yml #создаем файл и редактируем через VS Code`
5. `Проверка работоспособности ( на VM в docker-compose)`
  ![код 1 playbook] (https://github.com/Artwikafk/git-hw/ansible-project/ScreenShots/Check-Kafka.png)
  ![код 1 playbook] (https://github.com/Artwikafk/git-hw/ansible-project/ScreenShots/Check-Kafka2.png)
6. 

[код 1 playbook] (https://github.com/Artwikafk/git-hw/ansible-project/playbook1.yml)

```
---
- name: Download and extract archive
  hosts: web
  become: yes
  vars:
    download_url: "https://downloads.apache.org/kafka/3.6.0/kafka.tgz"
    download_dir: "/tmp"
    extract_dir: "/opt/kafka"
    archive_name: "kafka.tgz"

  tasks:
    - name: Create extraction directory
      file:
        path: "{{ extract_dir }}"
        state: directory
        mode: '0755'

    - name: Download Kafka archive
      get_url:
        url: "{{ download_url }}"
        dest: "{{ download_dir }}/{{ archive_name }}"
        timeout: 60
        validate_certs: yes

    - name: Extract archive
      unarchive:
        src: "{{ download_dir }}/{{ archive_name }}"
        dest: "{{ extract_dir }}"
        remote_src: yes
        extra_opts: [--strip-components=1]
        creates: "{{ extract_dir }}/bin"

    - name: Clean up archive file
      file:
        path: "{{ download_dir }}/{{ archive_name }}"
        state: absent

    - name: Display extraction result
      debug:
        msg: "Kafka extracted to {{ extract_dir }}"

```
[код 2 playbook] (https://github.com/Artwikafk/git-hw/ansible-project/playbook2.yml)

```
---
- name: Install and configure tuned
  hosts: web
  become: yes

  tasks:
    - name: Install tuned package
      apt:
        name: tuned
        state: present
        update_cache: yes

    - name: Ensure tuned service is started and enabled
      systemd:
        name: tuned
        state: started
        enabled: yes
        daemon_reload: yes

    - name: Verify tuned is running
      command: systemctl is-active tuned
      register: tuned_status
      changed_when: false
      failed_when: tuned_status.stdout != "active"

    - name: Display tuned status
      debug:
        msg: "Tuned service is {{ tuned_status.stdout }} on {{ ansible_hostname }}"

```
[код 3 playbook] (https://github.com/Artwikafk/git-hw/ansible-project/playbook3.yml)

```

---
- name: Change system MOTD
  hosts: all
  become: yes
  vars:
    motd_message: "Welcom to the Ansible homework"

  tasks:
    - name: Create custom MOTD file
      copy:
        content: |
          {{ motd_message }}
        dest: /etc/motd
        mode: '0644'
        owner: root
        group: root
        backup: yes

    - name: Display new MOTD
      debug:
        msg: "New MOTD set on {{ ansible_hostname }}"

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![код 1 playbook] (https://github.com/Artwikafk/git-hw/ansible-project/ScreenShots/playbook1-screen.png)
![код 2 playbook] (https://github.com/Artwikafk/git-hw/ansible-project/ScreenShots/playbook2-screen.png)
![код 3 playbook] (https://github.com/Artwikafk/git-hw/ansible-project/ScreenShots/playbook3-screen.png)

---

### Задание 2

`Приведите ответ в свободной форме........`

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

[код 3 playbook-modify] (https://github.com/Artwikafk/git-hw/ansible-project/playbook3-modify.yml)

```
---
- name: Dynamic MOTD with IP and hostname
  hosts: all
  become: yes
  vars:
    admin_name: "admin"
    
  tasks:
    - name: Gather facts
      setup:
      when: ansible_facts is not defined

    - name: Create dynamic MOTD file
      copy:
        content: |
          ****************************************
          Hostname: {{ ansible_hostname }}
          IP Address: {{ ansible_default_ipv4.address | default(ansible_all_ipv4_addresses[0]) }}
          
          Welcome {{ admin_name }}!
          Хорошего дня!
          ****************************************
        dest: /etc/motd
        mode: '0644'
        owner: root
        group: root
        backup: yes

    - name: Show MOTD content
      shell: cat /etc/motd
      register: final_motd
      changed_when: false

    - name: Print MOTD
      debug:
        var: final_motd.stdout_lines

```
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты`

![playbook3-modify](https://github.com/Artwikafk/git-hw/ansible-project/ScreenShots/playbook3-modify-screen.png)


---

### Задание 3

`Приведите ответ в свободной форме........`

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

[код playbook-apache] (https://github.com/Artwikafk/git-hw/ansible-project/playbook-apache.yml)

```
---
- name: Deploy Apache web server with system information
  hosts: web
  become: yes
  gather_facts: yes

  roles:
    - apache_webserver

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`

![playbook-apache](https://github.com/Artwikafk/git-hw/ansible-project/ScreenShots/playbook-apache.png)

### Задание 4

`Приведите ответ в свободной форме........`

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`
