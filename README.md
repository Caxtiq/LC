# LowC: Trình Tạo Biểu Mẫu Động cho Cứu Trợ Thiên Tai

## Giới Thiệu

LowC là một ứng dụng tạo biểu mẫu động được thiết kế để giải quyết một nhu cầu cấp thiết trong các nỗ lực cứu trợ thiên tai: **đánh giá nhu cầu chính xác và hiệu quả**. Trong sự hỗn loạn sau một thảm họa tự nhiên, việc biết chính xác những nguồn lực nào cần thiết và ở đâu là vô cùng quan trọng. Công cụ này cho phép các nhân viên cứu trợ nhanh chóng tạo và triển khai các biểu mẫu tùy chỉnh, đảm bảo rằng việc phân phối viện trợ có mục tiêu và hiệu quả.

## Vấn Đề

Sau một thảm họa, những người bị ảnh hưởng thường ở trong tình thế dễ bị tổn thương, và quá trình thu thập và phân phối nguồn lực có thể diễn ra chậm chạp, thiếu tổ chức và không hiệu quả:

*   **Biểu Mẫu Chung Chung:** Các biểu mẫu tiêu chuẩn có thể không nắm bắt được các nhu cầu cụ thể của từng khu vực bị ảnh hưởng.
*   **Dữ Liệu Không Chính Xác:** Dữ liệu không chính xác hoặc không đầy đủ có thể dẫn đến việc phân bổ sai nguồn lực và lãng phí nỗ lực.
*   **Giới Hạn Thời Gian:** Các nhân viên cứu trợ cần thu thập dữ liệu và phân phát viện trợ nhanh chóng để tránh những tổn thất và đau khổ hơn nữa.
*   **Khả Năng Tiếp Cận:** Công cụ thu thập dữ liệu cần phải dễ tiếp cận đối với những người ở hiện trường với kiến thức kỹ thuật hạn chế.

## Giải Pháp Của Chúng Tôi: LowC

LowC giải quyết thách thức này bằng cách cung cấp một trình tạo biểu mẫu động với các tính năng sau:

*   **Giao Diện Kéo và Thả:** Một giao diện kéo và thả đơn giản, trực quan cho phép người dùng tạo các biểu mẫu tùy chỉnh một cách nhanh chóng và dễ dàng bằng cách kéo các thành phần từ thanh bên vào vùng thả.
*   **Thành Phần Tùy Chỉnh:** Nền tảng bao gồm nhiều thành phần khác nhau có thể được cấu hình để yêu cầu các loại thông tin cụ thể, bao gồm:
    *   Các trường nhập văn bản cho thông tin cá nhân, địa điểm và mô tả.
    *   Các danh sách thả xuống để chọn tài nguyên, loại hỗ trợ hoặc mức độ ưu tiên.
    *   Các nút để thực hiện hành động ngay lập tức hoặc đánh dấu kết thúc một phần.
    *   Cửa sổ modal để hiển thị thông tin hoặc cung cấp thêm ngữ cảnh.
    *   Thẻ (card) để trình bày trực quan các dữ liệu tóm tắt.
    *   Danh sách có thể mở rộng để liệt kê chi tiết các tài nguyên.
    *   Điều hướng theo tab để tổ chức các biểu mẫu phức tạp.
    *   Danh sách thả xuống có thể tìm kiếm để nhập dữ liệu dễ dàng từ các danh sách định sẵn.
    *   Chốt đánh dấu bản đồ để thu thập dữ liệu dựa trên vị trí.
    *   Thành phần mục tài nguyên để thu thập thông tin chi tiết về loại tài nguyên và số lượng.
    *   Thành phần nhân sự để thu thập thông tin chi tiết về nhân sự.
    *   Thành phần sự kiện khẩn cấp để phân loại các sự kiện khẩn cấp khác nhau.
    *   Thành phần khu vực bị ảnh hưởng để xác định loại khu vực bị ảnh hưởng.
    *   Thành phần lập kế hoạch tuyến đường để xác định điểm bắt đầu và điểm kết thúc để phân phối.
    *   Thành phần theo dõi mục để theo dõi và báo cáo tiến độ.
    *   Thành phần danh sách công việc để ưu tiên và quản lý các nhiệm vụ.
        *   Thành phần cảnh báo để giao tiếp các tin nhắn khẩn cấp.
        *   Thành phần cung cấp thiết yếu để thu thập chi tiết về các nhu yếu phẩm.
*   **Chỉnh Sửa Trực Tiếp:** Các biểu mẫu có thể được chỉnh sửa ngay lập tức và các thay đổi được phản ánh ngay lập tức.
*   **Xuất Mã:** Sau khi tạo biểu mẫu, người dùng có thể xuất mã của biểu mẫu ở định dạng thành phần JavaScript có thể tái sử dụng.

**Cách Hoạt Động:**

1.  **Tạo Biểu Mẫu:** Người dùng kéo và thả các thành phần từ thanh bên vào vùng thả trung tâm để thiết kế các biểu mẫu tùy chỉnh của họ.
2.  **Cấu Hình Thành Phần:** Mỗi thành phần có thể được cấu hình với các thuộc tính cụ thể (ví dụ: văn bản giữ chỗ cho một trường nhập văn bản, hành động cho một nút, các mục cho danh sách thả xuống, v.v.).
3.  **Xem Trước Biểu Mẫu:** Người dùng xem bản trình bày thời gian thực của biểu mẫu đã tạo.
4.  **Xuất Mã:** Sau khi biểu mẫu hoàn thành, người dùng có thể xuất mã để triển khai lên trang web hoặc ứng dụng di động.
5.  **Triển Khai:** Tích hợp vào các nền tảng để thu thập dữ liệu tại hiện trường, hướng dẫn các nỗ lực cứu hộ và phân phối viện trợ.

## Cấu Trúc Dự Án

Dự án được tổ chức như sau:

```
lowc
├── Sidebar.tsx         # Thành phần Sidebar gốc (không sử dụng)
├── types               # Định nghĩa kiểu
│   └── ComponentItem.ts  # Interface định nghĩa thuộc tính thành phần
├── tailwind.config.js  # Cấu hình Tailwind CSS
├── app                 # Thư mục ứng dụng Next.js
│   ├── layout.tsx      # Layout gốc cho ứng dụng
│   ├── page.tsx        # Trang chính của ứng dụng
│   └── globals.css     # Các kiểu toàn cục
├── ExportedComponent.js  # Ví dụ về thành phần được xuất (không sử dụng)
├── ExportButton.tsx   # Nút để xuất mã biểu mẫu
├── next.config.js      # Cấu hình Next.js
├── next-env.d.ts      # Các biến môi trường của Next.js
├── components          # Các thành phần có thể tái sử dụng
│   ├── ui              # Các thành phần giao diện người dùng
│   │   ├── tabs.tsx     # Thành phần Tabs
│   │   ├── card.tsx     # Thành phần Card
│   │   ├── popover.tsx  # Thành phần Popover
│   │   ├── label.tsx    # Thành phần Label
│   │   ├── accordion.tsx # Thành phần Accordion
│   │   ├── command.tsx  # Thành phần Command (cho dropdown tìm kiếm)
│   │   ├── tab-navigation.tsx # Thành phần điều hướng theo tab
│   │   ├── searchable-dropdown.tsx # Thành phần dropdown có thể tìm kiếm
│   │   ├── dialog.tsx    # Thành phần hộp thoại modal
│   │   ├── button.tsx    # Thành phần nút
│   │   ├── toast.tsx    # Thành phần thông báo toast
│   │   ├── select.tsx    # Thành phần dropdown Select
│   │   ├── textarea.tsx  # Thành phần Textarea
│   │   └── input.tsx    # Thành phần nhập văn bản
│   ├── Sidebar.tsx     # Thành phần Sidebar
│   ├── ExportButton.tsx  # Nút để xuất mã biểu mẫu
│   ├── YouOwnProject.tsx # Thành phần vùng chứa chính với chức năng kéo và thả
│   ├── EditPanel.tsx    # Bảng điều khiển để chỉnh sửa thuộc tính thành phần
│   ├── DraggableItem.tsx # Thành phần để làm cho các mục có thể kéo được
│   └── DropArea.tsx    # Thành phần vùng thả
├── package-lock.json  # Tệp khóa cho các dependency
├── package.json       # Các dependency và script của dự án
├── YouOwnProject.tsx   # Thành phần vùng chứa chính với chức năng kéo và thả (không sử dụng)
├── lib                 # Các hàm và helper tiện ích
│   ├── utils.ts       # Các hàm tiện ích
│   └── observer.ts    # Bộ phát sự kiện toàn cục
├── tsconfig.json       # Cấu hình TypeScript
├── postcss.config.js   # Cấu hình PostCSS
├── EditPanel.tsx      # Bảng điều khiển để chỉnh sửa thuộc tính thành phần (không sử dụng)
├── DraggableItem.tsx   # Thành phần để làm cho các mục có thể kéo được (không sử dụng)
└── DropArea.tsx      # Thành phần vùng thả (không sử dụng)
```

## Các Tệp Quan Trọng Được Giải Thích

*   **`types/ComponentItem.ts`:** Xác định interface `ComponentItem`, phác thảo cấu trúc cho tất cả các thành phần biểu mẫu, bao gồm `id`, `type`, `content` và `props`.
*   **`components/ui/`:** Chứa các thành phần UI có thể tái sử dụng được xây dựng bằng Radix UI và Tailwind CSS, bao gồm các nút, trường nhập, modal, thẻ (card), danh sách thả xuống và hơn thế nữa.
*   **`components/Sidebar.tsx`:** Xác định thành phần thanh bên, chứa tất cả các thành phần có sẵn để kéo và thả.
*   **`components/YouOwnProject.tsx`:** Triển khai logic kéo và thả cốt lõi với `dnd-kit` và kết xuất giao diện xây dựng biểu mẫu chính với thanh bên, vùng thả và bảng chỉnh sửa.
*   **`components/EditPanel.tsx`:** Hiển thị và xử lý chỉnh sửa thuộc tính thành phần dựa trên thành phần đã chọn.
*   **`components/DraggableItem.tsx`:** Bọc một thành phần trong một vùng chứa có thể kéo được.
*    **`components/DropArea.tsx`:** Xác định vùng thả nơi các thành phần được di chuyển từ thanh bên.
*   **`components/ExportButton.tsx`:** Xử lý việc tạo và xuất mã biểu mẫu.
*   **`app/page.tsx`:** Trang chính của ứng dụng, bao gồm thành phần `YouOwnProject.tsx`.
*   **`lib/utils.ts`:** Chứa các hàm tiện ích, bao gồm hàm `cn` để hợp nhất tên lớp với `clsx` và `tailwind-merge`.
*   **`lib/observer.ts`:** Triển khai bộ phát sự kiện toàn cục để giao tiếp giữa các thành phần.

## Các Công Nghệ Được Sử Dụng

*   **Next.js:** Một framework React để xây dựng các ứng dụng web được render phía máy chủ.
*   **TypeScript:** Một tập hợp siêu của JavaScript với kiểu tĩnh để nâng cao khả năng phát triển.
*   **Tailwind CSS:** Một framework CSS theo tiện ích để tạo kiểu nhanh chóng.
*   **Radix UI:** Một thư viện các thành phần giao diện người dùng không được tạo kiểu, dễ truy cập.
*   **dnd-kit:** Một thư viện để xây dựng giao diện kéo và thả.

## Bắt Đầu

1.  **Sao chép kho lưu trữ:**
    ```bash
    git clone https://github.com/Caxtiq/LC.git
    cd lowc
    ```

2.  **Cài đặt các dependency:**
    ```bash
    npm install
    ```

3.  **Chạy máy chủ phát triển:**
    ```bash
    npm run dev
    ```

4.  Mở trình duyệt của bạn và điều hướng đến `http://localhost:3000`.

## Đóng Góp

Chúng tôi hoan nghênh những đóng góp! Vui lòng làm theo các hướng dẫn sau:

1.  Fork kho lưu trữ.
2.  Tạo một nhánh mới cho tính năng hoặc sửa lỗi của bạn.
3.  Thực hiện các thay đổi của bạn và commit chúng với các thông báo rõ ràng.
4.  Đẩy các thay đổi của bạn lên fork của bạn.
5.  Gửi một pull request với mô tả về các thay đổi của bạn.

## Các Cải Tiến Trong Tương Lai

*   **Xử Lý Dữ Liệu Biểu Mẫu:** Triển khai việc gửi và xử lý dữ liệu biểu mẫu.
*   **Tùy Chỉnh Thành Phần Nâng Cao:** Thêm nhiều thuộc tính tùy chỉnh hơn cho mỗi thành phần.
*   **Hệ Thống Mẫu:** Cho phép lưu và tải các mẫu biểu mẫu.
*   **Xác Thực Người Dùng:** Cho phép xác thực để bảo mật việc tạo và chỉnh sửa biểu mẫu.
*   **Logic Có Điều Kiện:** Triển khai hiển thị có điều kiện các thành phần biểu mẫu.
*   **Tích hợp với backend:** Để tích hợp với một backend gửi dữ liệu.

## Giấy Phép

Dự án này được cấp phép theo **Giấy phép Apache 2.0**. Xem [LICENSE](LICENSE) để biết thông tin chi tiết.

## Kết Luận

LowC đại diện cho một bước tiến có ý nghĩa hướng tới việc cải thiện hiệu quả và tính hiệu quả của việc cứu trợ thiên tai bằng cách cung cấp một công cụ để tạo và triển khai các biểu mẫu tùy chỉnh. Chúng tôi tin rằng nó có thể giúp những người bị ảnh hưởng bởi thiên tai nhận được các nguồn lực cần thiết và giúp nhân viên cứu trợ phân phối các nguồn lực đó tốt hơn.

Chúng tôi khuyến khích bạn khám phá codebase, đóng góp vào sự phát triển của nó và giúp chúng tôi cải thiện công cụ quan trọng này.
